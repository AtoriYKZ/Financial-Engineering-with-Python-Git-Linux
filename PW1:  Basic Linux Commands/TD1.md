# **Financial Engineering with Python**
# **TD1**


## **Exercise 1: Move around**

### 1. Go to the root directory
    cd /
### 2. Display the content of the current (root) directory
    ls
### 3. Check your current location
    pwd
### 4. Try to create a directory named test
    mkdir test
### 5. Go to the general home directory (should contain folders named after each user)
    cd ~
### 6. Go to your home directory
    cd ~
### 7. Go back to the general home directory (located "just above")
    cd ..
### 8. Go again "just above", you should be back to the root directory
    cd ..
### 9. Go directly to your home directory (named after you). It should be a very simple command, which take no name as parameter of the path
    cd
### 10. Try to create a directory named test
    mkdir test
### 11. Go into this new directory
    cd test
### 12. Check your current location
    pwd



## **Exercise 2: Create, Rename, copy, delete**

### 1. Go to your home directory (should be named after you, you might be there by default)
    cd ~
### 2. Check your current location
    pwd
### 3. Create a folder linux_ex_1
    mkdir linux_ex_1
### 4. Go into this folder
    cd linux_ex_1
### 5. Create an empty text file named [first_name]_[last_name].txt (e.g. alexis_bogroff.txt)
    touch pierrick_pinpin.txt
### 6. Create a folder notes
    mkdir notes
### 7. Move your text file into this folder
    mv pierrick_pinpin.txt notes/
### 8. Rename the text file by appending the current year [first_name]_[last_name]_[current_year].txt
    mv pierrick_pinpin.txt pierrick_pinpin_2023.txt
### 9. Make a copy of this folder, name it notes_2022
    cp -r notes notes_2022
### 10. Delete the first folder (notes) using the verbose option
    rm -rv notes



## **Exercise 3: Create and run a script**

### 1. Create a script script_1.sh in the folder linux_ex_1
    touch linux_ex_1/script_1.sh
### 2. In the script, write the commands that would output the following :
Script running please wait ...
Done.
    nano script_1.sh
### 3. Quit editing and save the script
    To save the script in a text editor, press Ctrl + X, then Y to confirm saving the changes, then Enter to confirm the file name.
### 4. Display the content of the script (using a command, not from an editor)
    cat linux_ex_1/script_1.sh
### 5. Run the script
    bash linux_ex_1/script_1.sh


## **Exercise 4: Accessing or modifying a file : permissions and root privilege**

## **Exercise 4:.1 Change the rights for accessing or modifying a file**

### 1. Create a file credentials in the folder linux_ex_1
    cd linux_ex_1
    touch credentials
### a) Write any kind of (fake) personal information within the file
    nano credentials
    Birthdate: 02/02/2001
### b) Display the file content
    cat credentials
### c) Display the current permissions
    ls -l credentials

### 2. Change the current permissions to : read only for all users
    chmod 444 credentials
### a) Display the new permissions
    ls -l credentials
### b) Modify and save the file
### c) Display the file content
    cat credentials
### 3. Change the permissions back to read and write for all users
    chmod 666 linux_ex_1/credentials
### a) Display the new permissions
    chmod 700 credentials
### b) Modify and save the file
    chmod 770 credentials
### c) Display the file content
    cat credentials
### On the same file :
### 1. Add the execute permission to the owner
    chmod u+x credentials
### a) Display the new permissions
    ls -l credentials
### 2. Remove the read permission to other users
    chmod o-r credentials
### a) Display the new permissions
    ls -l credentials
### 3. Change the permissions to read, write and execute for all users
    chmod a+rwx credentials
### a) Display the new permissions
    ls -l credentials

### **Exercise 4:.2 Access root files**

### 1. Go to the root folder
    cd /
### 2. Create a file in root user mode named .private_file
    sudo touch .private_file
### a) Write some information in the file
    sudo nano .privat_file
### b) Display the file content
    sudo cat .private_file
### c) Display all the files in the folder including hidden files
    ls -a
### 3. Modify the file in normal user mode
    nano .private_file
### a) Write some new information in the file
    [ File '.private_file' is unwritable ]
### b) Display the file content
    cat .private_file
### 4. Modify the file in root user mode
    sudo nano .private_file
### a) Write some new information in the file
    It is encrypted
### b) Display the file content
    cat .private_file
### 5. Change permissions to read, write and execute for all users
    sudo chmod a+rwx .private_file
### a) Modify the file content in normal user mode
    nano .private_file
### b) Display the file content
    cat .private_file

### **Exercise 4:.3 Change a file owner**

### 1. Change permissions of .private_file to read and write for all users, in normal user mode
    sudo chmod a+rw .private_file
### 2. Set the new file owner as the current user
    sudo chown $USER .private_file
### 3. Change permissions of .private_file to read and write for all users, in normal user mode
    chmod a+rw .private_file

### **Exercise 4:.4 Manage Packages (tools / functions)**
### 1. Update your main package manager named apt
    sudo yum update
    In my powershell, the package is not "apt" but "yum" because I am under Fedora or CentOS
### 2. Upgrade apt
    sudo yum update
### 3. Install the package cmatrix
    sudo yum install cmatrix 
    (but it doesn't work...)