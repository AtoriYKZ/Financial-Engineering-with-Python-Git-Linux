# **TD8:  Linux, Git and Python**

## **Exercise 1: Working Directory**

Using only command-line in your Linux shell,
### 1. Create an empty working directory called “td4”
    mkdir td4

### 2. Initialize a Git repository in it.
    cd td4/
    git init

### 3. Install the Linux python3-pip package using your Linux package manager.
    sudo yum update
    sudo yum install python3-pip

### 4. Install the VirtualEnv Python package using pip3.
    sudo pip3 install virtualenv

### 5. Create a Python virtual environment called “.env”. Do you see the change in your working directory ?
    virtualenv .env
    ls -a #We can see the new environment

### 6. Activate your virtual environment. Do you see the change in your prompt ?
    source .env/bin/activate
    #Yes we can see the new prompt: (.env) [ec2-user@ip-172-31-54-239 td4]$

### 7. List the Python packages installed in your virtual environment.
    pip list

### 8. Does Git want you to commit something ? Do you think it is a good thing ?
hint : You can find templates at https://github.com/github/gitignore

    git status
    #Nothing is suggested to me

### 9. Create a .gitignore file to tell Git which files should be untracked.
    touch .gitignore
    git add .gitignore
    git commit -m "Add .gitignore"

### 10. Does Git want you to commit something ? Do you think it is a good thing this time ?
    git status

### 11. Do your first commit and check that Git is happy now.



## **Exercise 2: Python Script**
Back to the Domesday Book, the greatest medieval census. It lists the manors (private properties) in every place of every county in England in the years 1066 and 1086, before and after the Norman conquest.
OpenDomesday presents it in a modern-human-readable website, as well as a RESTful web application programming interface API : https://opendomesday.org/api/


### 1. Install the Python package Requests using pip.
info : Requests is a simple, yet elegant HTTP library and the de facto standard for querying RESTful web API

    pip install requests

### 2. Create a Python script that returns the list of all place ids in Derbyshire.
hint : Look at the county structure inside the web API documentation
hint : As the web API returns JSON, no need to use regular expressions

    touch Derbyshire_id_list.py
    nano Derbyshire_id_list.py

Python script:

    import requests

    url = "https://opendomesday.org/api/"
    endpoint = "1.0/county/"

    Derbyshire_id_list = []
    tmp= []
    response = requests.get(url + endpoint)
    for x in response.json():
        if(x["name"]== "Derbyshire"):
            tmp.append(x["places_in_county"])

    for i in range(len(l[0])):
        Derbyshire_id_list.append(l[0][i]["id"])

    print(Derbyshire_id_list)

Bash:

    git add Derbyshire_id_list.py

### 3. Commit your changes in Git
    git commit -m "Add Derbyshire_id_list.py"



## **Exercise 3: Python Module**

### 1. Create a Python module with a get_manor_ids function that takes a place id as parameter and returns the list of manors.
    touch manors_id.py
    nano manors_id.py

Python script:
    
    import requests

    def get_manor_ids(place_id):

    url= "https://opendomesday.org/api/1.0/place/"
    if(type(place_id) != str):
        place_id = str(place_id)

    manors_id = []

    response = requests.get(url + place_id)

    for i in range(len(response.json()["manors"])):
        manors_id.append(response.json()["manors"][i]["id"])
    
    return manors_id

### 2. Check that calling your module does not produce any output.
    python manors_id.py

### 3. To test your module, open a python interpreter and call your function with the first place id from Derbyshire.
    python
    import manors_id
    manors_id.get_manor_ids(1036)
    #manors_id.get_manor_ids(1036)
    exit()

### 4. Add a if __name__ == ’__main__’ : block with your previous test, at the end of your module, to make it usable as a script.

    if __name__ == '__main__':
    
    first_place_id = 1036
    print(get_manor_ids(first_place_id))


### 5. Check that calling your module now does produce an output.
    python manors_id.py
    #[13038]

### 6. Commit your changes in Git
    git add manors_id.py
    git commit -m "Add manors_id.py"



## **Exercise 4: Python Program**

### 1. Enrich your module to get all manors in all places in Derbyshire.
We can create 2 new functions:

    def get_all_places_ids(name):
    
    if(type(name) != str):
        name = str(name)
        
    places = []
    url = "https://opendomesday.org/api/1.0/county/"
    response = requests.get(url)
    
    for x in response.json():
        if(x["name"] == "Derbyshire"):

            for i in range(len(x["places_in_county"])):
                places.append(x["places_in_county"][i]["id"])
                
    return places



    def get_all_manors_ids(name):
    
    manors = []
    
    places = get_all_places_ids(name)
    
    for x in places:
        manors_list = get_manor_ids(x)
        
        for y in manors_list:
            manors.append(y)
    return manors


### 2. Retrieve the geld paid and total ploughs owned by all those manors.

Geld function:

    def get_geld(manor_id):
        
        url = "https://opendomesday.org/api/1.0/manor/"
        
        response = requests.get(url + str(manor_id) + '/')
        geld = response.json()["geld"]
        
        return geld


    
    def get_all_gelds(manors_list):
        
        gelds_list = []
        
        for x in manors_list:
            geld = get_geld(x)
            gelds_list.append(geld)
            
        return gelds_list

Ploughs functions:

    def get_plough(manor_id):
    
        url = "https://opendomesday.org/api/1.0/manor/"
        
        response = requests.get(url + str(manor_id) + '/')
        plough = response.json()["ploughlands"]
        
        return plough

    def get_all_ploughs(manors_list):
        
        ploughs_list = []
        
        for x in manors_list:
            plough = get_plough(x)
            ploughs_list.append(plough)
            
        return ploughs_list


### 3. Create a Pandas DataFrame with the same information.
    import pandas as pd

    manors = get_all_manors_ids("Derbyshire")
    gelds = get_all_gelds(manors)
    ploughs = get_all_ploughs(manors)

    df_Derbyshire = pd.DataFrame({'Manors': manors, 'Gelds': gelds, 'Ploughs': ploughs})
    df_Derbyshire

### 4. Use Pandas to compute the sum of geld paid and total ploughs owned in Derbyshire.

Geld sum:
    
    geldSum = df_Derbyshire["Gelds"].sum()
    geldSum

Plough sum:

    ploughSum = df_Derbyshire["Ploughs"].sum()
    ploughSum

### 5. Add docstrings to your functions.
See the notebook

### 6. Commit your changes in Git.
    git add manors_id.py
    git commit -m "Add manors_id.py"