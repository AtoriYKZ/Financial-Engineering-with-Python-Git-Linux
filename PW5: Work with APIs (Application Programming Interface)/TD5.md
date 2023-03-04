## **TD5: Work with APIs (Application Programming Interface)**

## **Exercise 1: Extract data from a website**
The Domesday Book is the greatest medieval census. It lists the manors (private properties) in every place of every county in England in the years 1066 and 1086, before and after the Norman conquest. OpenDomesday presents it in a modern-human-readable website, as well as an application programming interface (API).
We will use this API to extract some data from our command-line shell.
**The Internet is your friend, do not hesitate to ask his help to find a better command.**

### 1. curl:
Check the data on https://opendomesday.org/api/, for instance
- https://opendomesday.org/api/1.0/county/
- https://opendomesday.org/api/1.0/place/2346/
- https://opendomesday.org/api/1.0/manor/181/
Can you find other interesting URLs ?

We can add:
- https://opendomesday.org/api/1.0/hundred/
- https://opendomesday.org/api/1.0/area/
- https://opendomesday.org/api/1.0/placesnear/?lat=52.5&lng=1.0&radius=10

### 2. curl and grep
Let’s try to get the ids for all the places in Derbyshire !

    curl  https://opendomesday.org/api/1.0/county/ | grep -o 'Derbyshire.*' | grep -oE '"id":[0-9]+'

    #To keep only the numbers:
    curl  https://opendomesday.org/api/1.0/county/ | grep -o 'Derbyshire.*' | grep -oE '"id":[0-9]+' | cut -d':' -f2

### 3. curl, grep and for
Now that we have ids for all the places in Derbyshire, we can load all their details...
And from their details, we can list all the details of their manors.
Go grep the data !
**You may write the raw data into a file to avoid downloading it everytime.**

    curl  https://opendomesday.org/api/1.0/county/ | grep -o 'Derbyshire.*' | grep -oE '"id":[0-9]+' | cut -d':' -f2 > Derbyshire_id.txt
    for id in $(cat Derbyshire_id.txt); do curl https://opendomesday.org/api/1.0/place/$id/ | grep -o 'manors.*' | grep -oE '"id":[0-9]+' | cut -d':' -f2 >> Derbyshire_manors.txt; done

### 4. curl, grep, for and sed
Now that we have a heap of raw data, we will extract the interesting parts.
In our case we want to count the geld paid by each manor and compare it to the number of ploughs it owns.
- Can you find the corresponding json fields ?

        https://opendomesday.org/api/1.0/manor/13038/ #For example

- Then you can list these numbers for each manor in Derbyshire.

        for manors in $(cat Derbyshire_manors.txt); do curl https://opendomesday.org/api/1.0/manor/$manors/ | grep -o '"geld":[0-9]*[.,]*[0-9]\+' | sed 's/"geld"://' >> Derbyshire_geld.txt; done

        for manors in $(cat Derbyshire_manors.txt); do curl https://opendomesday.org/api/1.0/manor/$manors/ | grep -o '"totalploughs":[0-9]*[.,]*[0-9]\+' | sed 's/"totalploughs"://' >> Derbyshire_ploughs.txt; done

- And format this in a proper comma-separated values (CSV) file.

        paste -d ',' Derbyshire_id.txt Derbyshire_manors.txt Derbyshire_geld.txt Derbyshire_plough.txt > Derbyshire.csv


### 5. discover new commands
The CSV file you created could be loaded in Excel. But do you have one ?
Use your search skills to find a way to sum values in a column and provide the final result.

    cut -d',' -f3 Derbyshire.csv | xargs | sed 's/\ /+/g' | bc #geld
    cut -d',' -f4 Derbyshire.csv | xargs | sed 's/\ /+/g' | bc #plough

### 6. Bonus
Use Vim to write a single bash script that does all of these actions.

    touch Derbyshire.sh
    vim Derbyshire.sh

    #Script of Derbyshire:

    #Get the ids 
    curl https://opendomesday.org/api/1.0/county/ | grep -o 'Derbyshire.*' | grep -oE '"id":[0-9]+' | cut -d':' -f2 > Derbyshire_id.txt

    #Load all the details of the manors
    for id in $(cat Derbyshire_id.txt); do
        curl https://opendomesday.org/api/1.0/place/$id/ | grep -o 'manors.*' | grep -oE '"id":[0-9]+' | cut -d':' -f2 >> Derbyshire_manors.txt
    done

    #Get the geld count
    for manor in $(cat Derbyshire_manors.txt); do
        curl https://opendomesday.org/api/1.0/manor/$manor/ | grep -o '"geld":[0-9]*[.,]*[0-9]\+' | sed 's/"geld"://' >> Derbyshire_geld.txt
        curl https://opendomesday.org/api/1.0/manor/$manor/ | grep -o '"totalploughs":[0-9]*[.,]*[0-9]\+' | sed 's/"totalploughs"://' >> Derbyshire_plough.txt
    done

    #CSV
    paste -d ',' Derbyshire_id.txt Derbyshire_manors.txt Derbyshire_geld.txt Derbyshire_plough.txt > Derbyshire.csv

    #Sums
    geld_sum=$(cut -d',' -f3 Derbyshire.csv | paste -sd+ - | bc)
    plough_sum=$(cut -d',' -f4 Derbyshire.csv | paste -sd+ - | bc)

    echo "Sum of geld paid: $geld_sum"
    echo "Sum of ploughs: $plough_sum"


    chmod +x Derbyshire.sh
    bash Derbyshire.sh