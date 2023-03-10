# **TD6:  Git Filesystem & Commits**

## **Exercise 1: Configure Git**

### 1. Check that Git is installed on your environment.
    sudo yum install git-core

### 2. Configure your name and e-mail globally.
    git config --global user.name PierrickPinpin
    git config --global user.mail pierrick.pinpin@edu.devinci.fr

### 3. Check that Git has correctly recorded these two pieces of information.
Hint : All Git commands have a -h flag to display the corresponding help. Look there for the option of the git config command that lists all Git configuration.

    git config -h
    git config --list

## **Exercise 2: Basic workflow with a single file**

### 1. Create a git repository
    git init my_first_repo

### 2. Check that git has correctly initiliazed a repository by displaying the files wihtin your current folder
    cd my_first_repo/
    ls -a

### 3. Check the current git status
    git status

### 4. Create a text file named “readme.md” whose content is “# Test repository”
     touch readme.md
     nano readme.md
     # Test repository
     cat readme.md

### 5. Check the current git status
    git status

### 6. Stage the file
    git add readme.md

### 7. Check the current git status
    git status

### 8. Commit the file
    git commit -m "Add readme.md file"

### 9. Check the current git status
    git status

### 10. Check the git logs
    git log

### 11. Which informations are displayed ?
    Author: PierrickPinpin <ec2-user@ip-172-31-54-239.ec2.internal>
    Date:   Wed Mar 1 08:34:19 2023 +0000

    Add readme.md file



## **Exercise 3: Basic workflow with multiple files treated separately**

### 1. Create two empty python files named “main.py” and “functions.py”
    touch main.py
    touch functions.py

### 2. Check the current git status
    git status

### 3. Stage only the file “main.py”
    git add main.py

### 4. Check the current git status
    git status

### 5. Commit the file with an appropriate message
    git commit -m "Add main.py file"

### 6. Check the current git status
    git status
### 7. Now stage and commit the file “functions.py”
    git add functions.py
    git commit -m "Add functions.py file"

### 8. Check the current git status
    git status

### 9. Check the git logs
    git log

## **Exercise 4: Basic workflow with multiple files treated all at once**

### 1. Create three empty files named “requirements.txt”, “.gitignore” and “.private”
    touch requirements.txt .gitignore .private

### 2. Check the current git status
    git status

### 3. Stage all the files at once
    git add requirements.txt .gitignore .private

### 4. Check the current git status
    git status

### 5. Commit the current staged files
    git commit -m "Add requirements.txt, .gitignore, and .private files"

### 6. Check the current git status
    git status

### 7. Check the git logs where each log is displayed on a single line
    git log --oneline



## **Exercise 5: Private files**

Files can be private in two ways :
- being a temporary file (like an open Excel would produce or Python Jupyter Notebook would produce). This would happen to anyone using your project.
- being a personal file (personal notes, etc.)

### 1. Emulate a temporary empty file by creating a file named “temp.ipynb”
    touch temp.ipynb

### 2. Check the current git status
    git status

### 3. Add an instruction to .gitignore to prevent git from tracking this temp file
    nano .gitignore
    temp.ipynb

### 4. Check the current git status
    git status

### 5. Create other temporary files named “temp.aux” and “temp.log”
    touch temp.aux temp.log

### 6. Check the current git status
    git status

### 7. Change your instruction in .gitignore to prevent git from tracking any file which name starts with “temp”
    nano .gitignore
    temp*

### 8. Check the current git status
    git status

### 9. Now let’s consider your personal notes will be added to the “.private” folder. Use the “exclude” git file to prevent git from tracking this “.private” folder
    cd .git/info/
    nano exclude
    .private/



## **Exercise 6: Difference between versions**

### 1. Add a online description of your repository in the “readme.md” file
    nano readme.md
    This is a test repository used for learning Git and GitHub through Linux.

### 2. Stage your “readme.md” file
    git add readme.md

### 3. Display the changes in your root directory since the last commit (not just the current status)
    git diff HEAD

### 4. Commit your change
    git commit -m "Add readme.md file"

### 5. Display the changes since the last commit
    git diff

### 6. Display again the changes in your root directory since the last commit
    git diff HEAD

### 7. Change some words in the description of the “readme.md”
    nano readme.md

    # Test repository

    This is a test repository used for learning Git and GitHub through Linux.
    It is some changes.

### 8. Display the changes since the last commit
    git diff



## **Exercise 7: Undo**

### 1. Suppress all your files.
    rm -r *

### 2. Use Git to restore your files.
    git checkout .

### 3. Backup your Git repository elsewhere (pretending a copy exists on another colleague’s computer or on a remote server).
    cp -r my_first_repo backup_copy
    tar -czf backup_copy.tgz backup_copy

### 4. Suppress your root directory, create a new empty one and use your backup to restore everything.
    sudo rm -r my_first_repo
    mkdir new_repo
    tar -xzf backup_copy.tgz -C new_repo/
    mv new_repo/backup_copy/* new_repo/
    sudo rm -r backup_copy/

### 5. Unstage your first file
    git reset main.py

### 6. Commit your two file changes directly, without staging them.
    git commit -a -m "Update functions.py and main.py"

### 7. Check your commit log history. Do you see your new commit ?
    git log

### 8. Without affecting your Git repository, set your root directory state as of the snapshot of your first commit.
    cp -r my_first_repo_backup/* my_first_repo/

### 9. Check your commit log history. You do not see all commits, do you ? How can you see all of them ?
    git log

### 10. Return to the snapshot of your your last commit.
    git checkout HEAD

### 11. Undo your second commit by adding a new commit that reverts it.
    git revert HEAD~2

### 12. Check the content of your root directory. Have your previous changes disappeard ?
    ls -a

### 13. Check your commit log history. Do you see your revert commit ?
    git log

### 14. Remove the last 2 commits from the history.
    git reset HEAD~2

### 15. Check the content of your root directory. Have your previous changes disappeard ?
    ls -a

### 16. Check your commit log history. Have you lost the last 2 commits ?
    git log



## **Exercise 8: Aliases**

### 1. Create a “s” alias for the git status command.
    git config --global alias.s status
    git s

### 2. Create a “co” alias for the git checkout command.
git config --global alias.co checkout
    git co

### 3. Create a “b” alias for the git branch command.
    git config --global alias.b branch
    git b

### 4. Create a “ci” alias for the git commit command.
    git config --global alias.ci commit
    git ci

### 5. Create a “dog” alias for the git log –all –decorate –oneline –graph command.
    git config --global alias.dog "log --all --decorate --oneline --graph"

### 6. Create a “dag” alias for the git log –all –decorate –graph command.
    git config --global alias.dag "log --all --decorate --graph"

### 7. Create a “list” alias for the git diff-tree –no-commit-id –name-only -r command.
    git config --global alias.list "diff-tree --no-commit-id --name-only -r"

### 8. Create a “unstage” alias for the git reset HEAD – command.
    git config --global alias.unstage "reset HEAD --"

### 9. Create a “last” alias for the git log -1 HEAD command.
    git config --global alias.last "log -1 HEAD"



## **Exercise 9: Hashing**

### 1. Create a root directory.
    mkdir root_directory

### 2. Create a text file inside whose content is “Hello World”.
    touch root_directory/hello.txt
    cd root_directory/
    nano hello.txt
    Hello World

### 3. What is the size of the file ?
    ls -lh hello.txt | awk '{print $5}'
    #12

### 4. Display the file content on the screen.
    cat hello.txt

### 5. Compute the SHA-1 hash of the file content.
hint : You can use the GNU core utilities sha1sum command.

    sha1sum hello.txt
    #648a6a6ffffdaa0badb23b8baf90b6168dd16b3a  hello.txt

### 6. What hash would Git compute on this file ?
hint : You can use the git hash-object plumbing command (no need to create a Git repository for the moment).
They are different aren’t they ?
Actually Git prepends 2 properties to the file content before hashing, compressing and saving it :
(a) the Git object type followed by a space character
(b) the file size followed by a null character (\0)

    git hash-object hello.txt
    #557db03de997c86a4a028e1ebd3a1ceb225be238
    #They are different

### 7. Create a second file whose content is what Git would really consider when saving your first file.
hint : The echo command has a -e flag to interpret backslash escapes.
    echo -e "blob 12\0Hello World" > hello2.txt

8. Compute the SHA-1 hash of this second file and check it is equal to the Git hash of your first file.
    sha1sum hello2.txt
    #557db03de997c86a4a028e1ebd3a1ceb225be238  hello2.txt



## **Exercise 10: Compressing**

### 1. Create an empty Git repository in your root directory (if you have accidentally already created a Git repository in your root directory, delete it before).
    git init

### 2. Check that Git is aware of your 2 files but does not track them yet.
    git status

### 3. Check that no object is stored yet in the objects subdirectory of your Git repository.
    ls .git/objects/

### 4. Create a directory inside the objects subdirectory of your Git repository, whose name is the first two characters of the SHA-1 hash computed in the previous exercise.
    mkdir .git/objects/55

### 5. Install the QPDF free command-line program.
Part of this program is the zlib-flate command that compress and uncompress files using the deflate algorithm.

    sudo yum install qpdf

### 6. Create a file inside the directory that you have just created, whose content is the deflate compression (level 1) of your second file and whose name is the last 38 characters of the SHA-1 hash computed in the previous exercise.
    sha1hash=$(sha1sum hello2.txt | cut -d " " -f1)
    name=$(echo ${sha1hash:-38})
    zlib-flate -compress <hello2.txt> .git/objects/55/$name

### 7. Check that Git successfully considers this file as one of its inner object.
hint : You can use the different flags of the git cat-file plumbing command.
    git cat-file -p $name

### 8. Backup your Git repository and create a new one.
    cd
    cp -r root_directory root_backup_copy
    tar -czf root_backup_copy.tgz new_repo

    mkdir final_repo
    cd final_repo/
    git init

### 9. Stage your first file in Git and check that its name and content are identical to yours.


### 10. Create another text file whose content is 100 lines of “Hello Mister i” (i varying from 1 to 100).
    for i in 100; do echo "Hello Mister $i" >> hello100.txt; done

### 11. Stage this new file in Git and check that the compression ratio on this second example is better than on the first one.
    git add hello100.txt
    ls -lh hello100.txt | awk '{print $5}'
    #17

    git ls-files --stage
    #100644 7c8cabd2f7d178e2da1c873d61ff84677ad39d17 0       hello100.txt
    git cat-file -s 7c8cabd2f7d178e2da1c873d61ff84677ad39d17
    #17

    

