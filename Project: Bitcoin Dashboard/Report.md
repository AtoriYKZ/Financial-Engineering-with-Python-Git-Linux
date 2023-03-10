# **Linux, Git and Python Project: Bitcoin Dashboard**
### **PINPIN Pierrick** 



## **Creating the directory of the project**

    mkdir BTC_Project
    cd BTC_Project/
    git init

## **Scrapping the data**

    touch get_BTC_prices.sh
    nano get_BTC_prices.sh

### Script of get_BTC_prices.sh:

    get_timestamp() {
        date +"%Y-%m-%d %H:%M:%S"
    }

    price=$(curl https://www.zonebourse.com/cours/cryptomonnaie/BITCOIN-BTC-USD-45553945/ | grep -oP 'data-id="45553945" data-type="Cryptoquotes" data-field="last" data-round="2"  >\K[0-9,.]+')

    timestamp=$(get_timestamp)

    echo "$timestamp,$price" >> /home/ec2-user/BTC_Project/prices.csv


Now we have to make this script executable:

    chmod a+x get_BTC_prices.sh

We can try to run the script to know if it works:

    bash get_BTC_prices.sh

Now we can run the following commands to know if it works:

    ls 
    cat prices.csv

## Let's set up the crontab:

    crontab -e
    */5 * * * * /bin/bash /home/ec2-user/BTC_Project/get_BTC_prices.sh

## Now the python script:

    import dash
    from dash import dcc
    from dash import html
    from dash import dash_table
    from dash.dependencies import Input, Output
    import dash_bootstrap_components as dbc
    import pandas as pd
    from datetime import datetime, timedelta
    import numpy as np
    import plotly.graph_objs as go

    # 5 minutes data
    df = pd.read_csv("prices.csv")

    df.columns = ["Date", "Prices"]
    df["Date"] = pd.to_datetime(df['Date'])
    df["Returns"] = df["Prices"].pct_change()


    # Daily data

    df_day = pd.read_csv("daily_prices.csv")
    df_day.columns = ["Date", "Prices"]
    df_day["Date"] = pd.to_datetime(df_day['Date'])
    df_day["Returns"] = df_day["Prices"].pct_change()



    # Functions:
    def VaR(prices, alpha=0.05):

        returns = prices.pct_change().dropna()

        var = np.percentile(returns, alpha * 100)

        return var


    def ES(prices, alpha=0.05):

        returns = prices.pct_change().dropna()

        var = np.percentile(returns, alpha * 100)

        es = returns[returns <= var].mean()

        return es


    def Volatility(prices):
        
        returns = prices.pct_change().dropna()
        
        avg_returns = returns.mean()
        
        std_returns = returns.std(ddof=1)
        
        ann_volatility = std_returns * np.sqrt(252)
        
        return ann_volatility


    def MaxDrawDown(prices):

        max_price = prices.cummax()
        drawdown = (prices - max_price) / max_price
        max_drawdown = drawdown.min()
        return max_drawdown


    def MaxPriceLastDay(df):

        df['Date'] = pd.to_datetime(df['Date'])

        last_day = df['Date'].max().date()

        last_day_data = df[df['Date'].dt.date == last_day]

        max_price = last_day_data['Prices'].max()

        return max_price


    def MinPriceLastDay(df):

        df['Date'] = pd.to_datetime(df['Date'])

        last_day = df['Date'].min().date()

        last_day_data = df[df['Date'].dt.date == last_day]

        min_price = last_day_data['Prices'].min()

        return min_price


    # Returns:

    # All the time
    lowest_return = df['Returns'].min()
    avg_return = df['Returns'].mean()
    highest_return = df['Returns'].max()

    # Daily
    lowest_return_day = df_day['Returns'].min()
    avg_return_day = df_day['Returns'].mean()
    highest_return_day = df_day['Returns'].max()



    # Values:

    # Daily
    open_day = df_day['Prices'].iloc[0]
    close_day = df_day['Prices'].iloc[-1]
    max_price_day = MaxPriceLastDay(df_day)
    min_price_day = MinPriceLastDay(df_day)
    avg_price_day = round(df_day['Prices'].mean(), 2)
    highest_day = df_day['Prices'].max()
    lowest_day = df_day['Prices'].min()

    #["Open", "Close", "Min", "Average", "Max", "Lowest", "Highest"]

    # All the time
    open = df['Prices'].iloc[0]
    close = df['Prices'].iloc[-1]
    max_price = MaxPriceLastDay(df)
    min_price = MinPriceLastDay(df)
    avg_price = round(df['Prices'].mean(), 2)
    highest = df['Prices'].max()
    lowest = df['Prices'].min()

    last_price = df['Prices'].iloc[-1]




    # Metrics:

    # Daily
    mdd_day = round(MaxDrawDown(df_day['Prices']), 4)
    vol_day = round(Volatility(df_day['Prices']), 4)
    var_day = round(VaR(df_day['Prices']), 4)
    es_day = round(ES(df_day['Prices']), 4)

    # All the time
    var = round(VaR(df['Prices']), 4)
    es = round(ES(df['Prices']), 4)
    vol = round(Volatility(df['Prices']), 4)
    mdd = round(MaxDrawDown(df['Prices']), 4)






    app = dash.Dash(__name__, external_stylesheets=[dbc.themes.DARKLY])


    app.layout = html.Div(children=[
        html.H1(children='Bitcoin Prices Dashboard', style={
            'textAlign': 'center', 
            'marginBottom': '60px',
            'fontFamily': 'Verdana',
            'font-weight': 'bold'
        }),
        
        html.Div([
            html.Div(children=[
            html.H2(children=[
                html.Span('Last BTC price: ', style={'font-size': 30, 'color': '#016FB9'}), 
                html.Span(f'{last_price:,.2f} USD', style={'font-size': 40, 'color': 'white', 'border': '2px solid #016FB9', 'padding': '5px'})], 
                    style={
                'textAlign': 'center', 
                'marginBottom': '60px',
                'fontFamily': 'Verdana',
                'font-weight': 'bold'
            }),
            ], className='col-md-9 offset-md-1')
        ], className='row', style={'margin': 'auto'}),




        html.Div([
            html.H3(children='Values (in USD):', style={
                'marginBottom': '30px',
                'fontFamily': 'Verdana', 
                'font-weight': 'bold', 
                'color': '#016FB9'}),
            
            dash_table.DataTable(
                id='BTC_daily_values',
                columns=[{"name": i, "id": i} for i in ["Open", "Close", "Min", "Average", "Max", "Lowest", "Highest"]],
                data=[{"Open": open, "Close": close, "Min": min_price, "Average": avg_price, "Max": max_price, "Lowest": lowest, "Highest": highest}], 
                style_cell={'textAlign': 'center'},
                style_header={
                    'backgroundColor': '#1A1A1A',
                    'font-weight': 'bold',
                    'font-size': 25,
                    'color': '#016FB9'
                },
                style_data={
                    'backgroundColor': '#333333',
                    'color': 'white',
                    'font-size': 20
                }
            )
        ], className='col-md-10 offset-md-1', style={'marginBottom': '40px'}),
        
        html.Div([
            dcc.Graph(
                id='BTC_prices_plot',
                figure={
                    'data': [
                        {'x': df['Date'], 'y': df['Prices'], 'type': 'line', 'name': 'Bitcoin price over time', 'line': {'color': '#1A1A1A'}},
                    ],
                    'layout': {
                        'title': {
                            'text': 'Bitcoin price over time',
                            'font': {'size': 30, 'fontFamily': 'Verdana', 'weight': 'bold'}
                        },
                        'yaxis': {
                            'title': 'Price in USD'
                        }
                    }
                }
            )
        ], className='col-md-10 offset-md-1', style={'marginBottom': '40px'}),


        html.Div([
            html.H3(children='Risk Measures:', style={
                'marginBottom': '30px',
                'fontFamily': 'Verdana', 
                'font-weight': 'bold', 
                'color': '#016FB9'}),
                
            dash_table.DataTable(
                id='BTC_metrics',
                columns=[{"name": i, "id": i} for i in ["Volatility", "Value at Risk (95%)", "Expected Shortfall (95%)", "Max Draw Down"]],
                data=[{"Volatility": f'{vol*100:.2f}%', "Value at Risk (95%)": f'{var*100:.2f}%', "Expected Shortfall (95%)": f'{es*100:.2f}%', "Max Draw Down": f'{mdd*100:.2f}%'}], 
                style_cell={'textAlign': 'center'},
                style_header={
                    'backgroundColor': '#1A1A1A',
                    'font-weight': 'bold',
                    'font-size': 25,
                    'color': '#016FB9'
                },
                style_data={
                    'backgroundColor': '#333333',
                    'color': 'white',
                    'font-size': 20
                }
            )
        ], className='col-md-10 offset-md-1', style={'marginBottom': '40px'}),
        
        
        
        
        html.Div([
                html.H3(children='Returns:', style={
                    'marginBottom': '30px',
                    'fontFamily': 'Verdana', 
                    'font-weight': 'bold', 
                    'color': '#016FB9'}),
                    
                dash_table.DataTable(
                    id='BTC_returns',
                    columns=[{"name": i, "id": i} for i in ["Lowest", "Average", "Highest"]],
                    data=[{"Lowest": f'{lowest_return*100:.2f}%', "Average": f'{avg_return*100:.2f}%', "Highest": f'{highest_return*100:.2f}%'}], 
                    style_cell={'textAlign': 'center'},
                    style_header={
                        'backgroundColor': '#1A1A1A',
                        'font-weight': 'bold',
                        'font-size': 25,
                        'color': '#016FB9'
                    },
                    style_data_conditional=[
                        {
                            'if': {'column_id': i},
                            'backgroundColor': '#333333',
                            'color': 'green' if c > 0 else 'red',
                            'font-size': 20,
                            'fontWeight': 'bold'
                        } for i, c in zip(["Lowest", "Average", "Highest"], [lowest_return, avg_return, highest_return])
                    ]
                )
            ], className='col-md-10 offset-md-1', style={'marginBottom': '300px'}),
        
        








        html.Div([
            
            html.H2(children='Daily report', style={
                'textAlign': 'center',
                'marginBottom': '30px',
                'fontFamily': 'Verdana', 
                'font-weight': 'bold', 
                'color': 'white'}),
        
        ], className='col-md-10 offset-md-1', style={'marginBottom': '40px'}),
        
        html.Div([
            html.H3(children='Daily Values (in USD):', style={
                'marginBottom': '30px',
                'fontFamily': 'Verdana', 
                'font-weight': 'bold', 
                'color': '#016FB9'}),
            
            dash_table.DataTable(
                id='BTC_daily_values',
                columns=[{"name": i, "id": i} for i in ["Open", "Close", "Min", "Average", "Max", "Lowest", "Highest"]],
                data=[{"Open": open_day, "Close": close_day, "Min": min_price_day, "Average": avg_price_day, "Max": max_price_day, "Lowest": lowest_day, "Highest": highest_day}], 
                style_cell={'textAlign': 'center'},
                style_header={
                    'backgroundColor': '#1A1A1A',
                    'font-weight': 'bold',
                    'font-size': 25,
                    'color': '#016FB9'
                },
                style_data={
                    'backgroundColor': '#333333',
                    'color': 'white',
                    'font-size': 20
                }
            )
        ], className='col-md-10 offset-md-1', style={'marginBottom': '60px'}),
            
            

        html.Div([
            
            dcc.Graph(
                id='BTC_daily_prices_plot',
                figure={
                    'data': [
                        {'x': df_day['Date'], 'y': df_day['Prices'], 'type': 'line', 'name': 'Bitcoin price over time', 'line': {'color': '#1A1A1A'}},
                    ],
                    'layout': {
                        'title': {
                            'text': 'Bitcoin price over time',
                            'font': {'size': 25, 'weight': 'bold'}
                        },
                        'yaxis': {
                            'title': 'Price in USD'
                        }
                    }
                }
            )
        ], className='col-md-10 offset-md-1', style={'marginBottom': '40px'}),
        
        
        html.Div([
            html.H3(children='Daily Risk Measures:', style={
                'marginBottom': '30px',
                'fontFamily': 'Verdana', 
                'font-weight': 'bold', 
                'color': '#016FB9'}),
            
            dash_table.DataTable(
                id='BTC_metrics',
                columns=[{"name": i, "id": i} for i in ["Volatility", "Value at Risk (95%)", "Expected Shortfall (95%)", "Max Draw Down"]],
                data=[{"Volatility": f'{vol_day:.2%}', "Value at Risk (95%)": f'{var_day:.2%}', "Expected Shortfall (95%)": f'{es_day:.2%}', "Max Draw Down": f'{mdd_day:.2%}'}], 
                style_cell={'textAlign': 'center'},
                style_header={
                    'backgroundColor': '#1A1A1A',
                    'font-weight': 'bold',
                    'font-size': 25,
                    'color': '#016FB9'
                },
                style_data={
                    'backgroundColor': '#333333',
                    'color': 'white',
                    'font-size': 20
                }
            )
        ], className='col-md-10 offset-md-1', style={'marginBottom': '40px'}),
        
        
        
        
        html.Div([
            html.H3(children='Daily Returns:', style={
                'marginBottom': '30px',
                'fontFamily': 'Verdana', 
                'font-weight': 'bold', 
                'color': '#016FB9'}),
                
                dash_table.DataTable(
                    id='BTC_returns',
                    columns=[{"name": i, "id": i} for i in ["Lowest", "Average", "Highest"]],
                    data=[{"Lowest": f'{lowest_return_day*100:.2f}%', "Average": f'{avg_return_day*100:.2f}%', "Highest": f'{highest_return_day*100:.2f}%'}], 
                    style_cell={'textAlign': 'center'},
                    style_header={
                        'backgroundColor': '#1A1A1A',
                        'font-weight': 'bold',
                        'font-size': 25,
                        'color': '#016FB9'
                    },
                    style_data_conditional=[
                        {
                            'if': {'column_id': i},
                            'backgroundColor': '#333333',
                            'color': 'green' if c > 0 else 'red',
                            'font-size': 20,
                            'fontWeight': 'bold'
                        } for i, c in zip(["Lowest", "Average", "Highest"], [lowest_return_day, avg_return_day, highest_return_day])
                    ]
                )
        ], className='col-md-10 offset-md-1', style={'marginBottom': '100px'})

            
        
        
    ], style={'backgroundColor': '#1A1A1A', 'color': 'white', 'padding-top': '30px', 'margin': 'auto'})



    if __name__ == '__main__':
        app.run_server(debug=True, port= 8510, host='0.0.0.0')
        

We need to make it executable:

    chmod a+x Dashboard_BTC.py
    
## Update script:

    touch update.sh
    nano update.sh

Script of update.sh:

    # Kill the process listening on port 8510
    sudo fuser -k 8510/tcp

    # Start the Python script
    python3 /home/ec2-user/BTC_Project/Dashboard_BTC.py &

Now, we want to make it executable:

    chmod a+x update.sh



## Daily report:

    touch get_daily_data.sh
    nano get_daily_data.sh

Script of get_daily_data.sh:

    tail -n 288 prices.csv | cut -d ',' -f 1,2,4 > daily_prices.csv
    #288 lines because 24*60/5= 288

We have to make it executable:

    chmod a+x get_daily_data.sh

Now let's configure the crontab so that the script runs at 8pm every day:

    crontab -e
    0 20 * * * /bin/bash /home/ec2-user/BTC_Project/get_daily_data.sh
    
## Git:

    git add . #Add all the files in once
    git commit -m "Add all the project's files"
    git status #To check if everything is okay

# **Where is the project ?**

http://100.25.193.32:8510/