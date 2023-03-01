# **Financial Engineering with Python**
# **TD2**


## **Exercise 1: Access general computer informations**

### 1. Put system up to date
    
### 2. Display
- Linux version
- Current processes and memory usage associated
- Display it in a more pleasant way ("more readable for humans")
- Number of processors
- L1, L2 and L3 cache size
- Disk space
- Monted devices
- Connected usb devices
- Hostname

        


## **Exercise 2: Shell - Variables and scripts scope**

### 1. Create a variable x and assign it the short text piri pimpin
    x="piri pimpin"

### 2. Display the value of this variable
    echo $x

### 3. Add to this value the following text piri pimpon. It should contain the following : piri pimpim piri pimpon
    x="$x piri pimpon"
    echo $x

### 4. Create a folder named my_programs, then enter into that folder
    mkdir my_programs
    cd my_programs

### 5. Create a script named pilou that displays pilou pilou
    nano pilou
    echo "pilou pilou"
    
### 6. Run this script
    ./pilou

### 7. Make this script executable
    chmod +x pilou

### 8. Run the script by writting its name only
    export PATH=$PATH:$(pwd)
    pilou

### 9. Programs called from the terminal are usually found thanks to a variable named PATH. Display the content of the variable PATH
    echo $PATH

### 10. Add the path of your current location to the global variable PATH
    export PATH=$(getconf PATH) #Reset 
    echo 'export PATH=$PATH:$(pwd)' >> ~/.bashrc
    export PATH=$PATH:$(pwd)
    echo $PATH

### 11. When you are sure of the result, export it
    export PATH=$PATH:$(pwd)

### 12. Go to your home directory
    cd

### 13. Run your script by writting its name only
    pilou

### 14. Change the value of the PATH in the .profile file in order to make it permanent
    nano ~/.profile
    source ~/.profile
    echo $PATH

### 15. Create a new shell and run your script using its name only
    bash
    pilou



## **Exercise 3: Scheduling task - daemon**

### 1. Create a script say_hello.sh
- Make it write the current date and time followed by ’Hello’
- It should write it in a file named ’hellos.txt’
- Each new output should be appened to the file (it shouldn’t remove previous hellos)
    touch say_hello.sh
    touch hellos.txt
    nano say_hello.sh
    echo "Current date and time: $date Hello" >> /home/ec2-user/hellos.txt

### 2. Make the script executable
    chmod +x say_hello.sh

### 3. Use crontab to schedule the running of the script every minute
    crontab -e
    * * * * * /home/ec2-user/say_hello.sh


## **Exercise 4: Hashing**

### 1. Create a folder named hash_checksum. Go into this folder
    mkdir hash_checksum

### 2. Inside this folder, create two files named .sensible_addresses and .sensible_passwords
    cd hash_checksum
    touch .sensible_addresses
    touch .sensible_passwords

### 3. Display the list of files of the folder
    ls -a

### 4. Still inside the folder hash_checksum, create a script named gentle_script.sh. This script should display the following text "Have a good day"
    touch gentle_script.sh
    nano gentle_script.sh
    echo "Have a good day"

### 5. Run the script
    chmod +x gentle_script.sh
    ./gentle_script.sh

### 6. Compute the sha256sum of gentle_script. Store it into a file named log_sha
    sha256sum gentle_script.sh > log_sha

### 7. Now corrupt the file by adding a line of code that deletes any file starting with : ".sensible"
    nano gentle_script.sh

    echo "Have a good day"
    rm .sensible*

### 8. Compute again the sha256sum of gentle_script. Store it into the log_sha file
    sha256sum gentle_script.sh > log_sha

### 9. Run the script
    ./gentle_script.sh

### 10. Display again the list of files of the folder
    ls -a
### 11. Display the log_sha content : are the hashes any different ?
    cat log_sha

    #Yes, they are:
    2e009073db1dcf6b13ebe2b60736578ed69ed077586844fb7ea774637ccfcac7  gentle_script.sh
    715ebf0d2f136696a18e74d70f45c14a6aea56610f4b6f065d215dfe1cc3e175  gentle_script.sh

## **Exercise 5: Compressing**

### 1. Install the QPDF free command-line program. Part of this program is the zlib-flate command that compress and uncompress files using the deflate algorithm
    sudo yum install qpdf

### 2. Create a directory "compress", go into this directory
    mkdir compress
    cd compress/

### 3. Create a first file "hello" whose content is "Hello"
    nano hello
    Hello

### 4. Compute the deflate compression (level 1) of this file. Store the compressed file size into a file log_compress
    zlib-flate -compress <hello> hello.zlib
    du -h hello.zlib > log_compress

### 5. Create a second file "hello_multiple" whose content is 1000 lines of "Hello"
    yes "Hello" | head -n 1000 > hello_multiple

### 6. Compute the deflate compression (level 1) of this file. Store the compressed file size into a file log_compress
    zlib-flate -compress <hello_multiple> hello_multiple.zlib
    du -h hello_multiple.zlib >> log_compress

### 7. Create a third file "hello_mulitple_i" whose content is 1000 lines of "Hello i" (i varying from 1 to 100)
    for i in {1..100}; do echo "Hello $i" >> hello_multiple_i; done

### 8. Compute the deflate compression (level 1) of this third file. Store the compressed file size into log_compress
    zlib-flate -compress <hello_multiple_i> hello_multiple_i.zlib
    du -h hello_multiple_i.zlib >> log_compress

### 9. Display the content of log_compress
    cat log_compress
### 10. Compute the compression ratio of each file, also display it as a simple fraction (e.g. 12.6 => 10 :1)
    #hello
    uncompressed_size=$(wc -c < hello)
    compressed_size=$(wc -c < hello.zlib)
    compression_ratio=$(echo $uncompressed_size / $compressed_size)
    echo $compression_ratio

    #hello_multiple
    uncompressed_size=$(wc -c < hello_multiple)
    compressed_size=$(wc -c < hello_multiple.zlib)
    compression_ratio=$(echo $uncompressed_size / $compressed_size)
    echo $compression_ratio

    #hello_multiple_i
    uncompressed_size=$(wc -c < hello_multiple_i)
    compressed_size=$(wc -c < hello_multiple_i.zlib)
    compression_ratio=$(echo $uncompressed_size / $compressed_size)
    echo $compression_ratio

### 11. Analyse the results


## **Exercise 6: ACLs : Access Control Lists**

### 1. Create users
- Create a user named client_1 with password passwd-client_1
- Create two other users named contributor_1 and contributor_2 with respective passwords passwd-contributor_1 and passwd-contributor_2

        sudo useradd client_1
        sudo passwd client_1
        passwd-client_1
        #BAD PASSWORD: The password contains the user name in some formBAD PASSWORD: The password contains the user name in some form

        sudo useradd contributor_1
        sudo useradd contributor_2
        sudo passwd contributor_1
        sudo passwd contributor_2

### 2. Create groups
- clients
- contributors

        sudo groupadd clients
        sudo groupadd contributors

### 3. Add users to their respective group
    sudo usermod -aG clients client_1
    sudo usermod -aG contributors contributor_1
    sudo usermod -aG contributors contributor_2

### 4. Check the users and groups have been successfully created
    cat /etc/group | cut -d: -f1

### 5. Create a folder lika_project and give it the following authorizations to groups
- clients : read
- contributors : read and write

        mkdir lika_project
        sudo chgrp clients lika_project
        sudo chmod g=r lika_project
        sudo chgrp contributors lika_project
        sudo chmod g=rw lika_project

### 6. Also use the command ls -l and notice the change on lika_project folder
    ls -l
    #drwxrw-r-x 2 ec2-user contributors      6 Mar  1 11:25 lika_project

### 7. Change user and become as a client, then try deleting the folder
    su client_1
    rm lika_project
    #rm: cannot remove ‘lika_project’: Permission denied

### 8. Now change user and become as a contributor, then try deleting the folder
    su contributor_1
    rm lika_project
    #rm: cannot remove ‘lika_project’: Permission denied

### 9. Check who is the current user
    whoami

