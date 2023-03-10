get_timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

price=$(curl https://www.zonebourse.com/cours/cryptomonnaie/BITCOIN-BTC-USD-45553945/ | grep -oP 'data-id="45553945" data-type="Cryptoquotes" data-field="last" data-round="2"  >\K[0-9,.]+')

timestamp=$(get_timestamp)

echo "$timestamp,$price" >> /home/ec2-user/BTC_Project/prices.csv