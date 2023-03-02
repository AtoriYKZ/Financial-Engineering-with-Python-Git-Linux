# **TD4: Work with secured distant communication tools**

## **Exercise 1: SSH**

### 1. Create an account on a cloud computing platform (AWS, Azure, Google Cloud, IBM Cloud)
- You must enter your credit card number, I have no affiliation
- It is free. Delete the account in few month to prevent any fee

### 2. Create a server instance on the website of your cloud platform (ec2 for AWS, Standard B1s for Azure)

### 3. Connect to the distant server via your terminal
- Do chmod 400 your private key file. The connection won’t work otherwise
- Use an SSH instruction to connect to your remote instance
- Exit to return to your local machine

### 4. Create a script named connect.sh to automatically connect to the remote instance
    touch connect.sh
    nano connect.sh
    ssh -i "key.pem" ec2-user@ec2-xxx-xxx-xxx-xxx.compute-1.amazonaws.com

### 5. Run the script to check it is working properly. Then exit to return to your local machine.
    chmod +x connect.sh
    bash connect.sh

### 6. Rename your private key to make it a hidden file. Propagate the changes to your script. Run the script.
    mv key.pem .key.pm
    nano connect.sh
    ssh -i ~/.key.pem ec2-user@ec2-xxx-xxx-xxx-xxx.compute-1.amazonaws.com


## **Exercise 2: SCP**

### 1. On your local machine create a file named test_to_remote_instance.txt
    touch test_to_remote_instance.txt

### 2. Connect to your remote instance and create a file named test_from_remote_instance.txt. Then exit
    bash connect.sh
    touch test_from_remote_instance.txt
    exit

### 3. Use the scp command to :
- Send your file test_to_remote_instance.txt to the home folder of your remote instance
- Get the file test_from_remote_instance.txt to your current local directory

        scp -i ssh -i ~/.key.pem test_to_remote_instance.txt ec2-user@xxx.xxx.xxx.xxx:~
        scp -i ~/.key.pem ec2-user@xxx.xxx.xxx.xxx:/home/ec2-user/test_from_remote_instance.txt ~/Learn_Linux/

### 4. Create two scripts :
- scp_to_remote_instance.sh and scp_from_remote_instance.sh to respectively send and get data with your remote instance
- Since you would like to send or receive any file (not just the test file), your scripts should use the path of the file to send / receive as an argument

        touch scp_to_remote_instance.sh
        touch scp_from_remote_instance.sh

        nano scp_to_remote_instance.sh
        #Script for scp_to_remote_instance.sh:

        if [ $# -lt 2 ]; then
            echo "Usage: $0 <path-to-local-file> <path-to-remote-instance>"
            exit 1
        fi

        local_file=$1
        remote_path=$2
        remote_user=ec2-user@xxx.xxx.xxx.xxx

        scp -i ssh -i ~/.key.pem $local_file $remote_user:$remote_path

        chmod +x scp_to_remote_instance.sh




        nano scp_from_remote_instance.sh
        #Script for scp_to_remote_instance.sh:

        if [ $# -lt 2 ]; then
            echo "Usage: $0 <path-to-remote-file> <path-to-local-directory>"
            exit 1
        fi

        remote_path=$1
        local_path=$2
        remote_user=ec2-user@xxx.xxx.xxx.xxx

        scp -i ~/.key.pem $remote_user:$remote_path $local_path

        chmod +x scp_from_remote_instance.sh


### 5. Test your scripts with varying files

    #Import
    touch test.txt
    nano test.txt
    Some data to be exported.
    bash scp_to_remote_instance.sh test.txt /home/ec2-user

    #Export
     bash scp_from_remote_instance.sh /home/ec2-user/remote_test.txt /home/pierrick/Learn_Linux/

