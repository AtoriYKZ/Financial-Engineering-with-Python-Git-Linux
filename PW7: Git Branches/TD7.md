# **TD7: Git Branches**

These exercises must be done by teams of 3-4 students.

## **Exercise 1: Clone a Git repository**
    git config --global user.name PierrickPINPIN
    git config --global user.email pierrick.pinpin@gmail.com

### 1. Choose the repository created on GitHub or GitLab by one of your teammates, share its web URL.
    https://github.com/gabriel-bar-linux/td-group-gith-branch

### 2. For the repository owner... Ensure there is at least a README.md file, it appears on the project frontpage in the web UI.

### 3. Using only command-line in your Linux shell, clone it to a local repository.
    git clone https://github.com/gabriel-bar-linux/td-group-gith-branch

### 4. For the repository owner... Give push rights to your teammates :
- on GitHub got to "Settings", "Manage access", "Invite a collaborator" see https ://docs.github.com/en/github/setting-up-and-managing-yourgithub-user-account/inviting-collaborators-to-a-personal-repository
- on GitLab got to "Members", "Invite member" see https ://docs.gitlab.com/ee/user/project/members/
hint : All Git commands have a -h flag to display the corresponding help.
hint : Unless you setup a SSH private key, you want to clone using the HTTPS address, not the SSH or CLI one.

## **Exercise 2: Push files to common repository**

Using only the shell in your local repository :

### 1. Create a branch named after you.
    git branch PierrickPINPIN
    git checkout PierrickPINPIN

### 2. Create a new text file named after you (with the content you want).
    touch PierrickPINPIN.txt
    nano PierrickPINPIN.txt

    #nano script:
    Name: PINPIN
    First name: Pierrick
    Birthdate: 02/02/2001
    College: ESILV
    GitHub: https://github.com/PierrickPINPIN

### 3. Commit this new file.
    git add PierrickPINPIN.txt
    git commit -m "Add the PierrickPINPIN.txt file by PierrickPINPIN"

### 4. Push your branch to the remote repository.
Check in the web UI you see your branch (there is a button with 'master' as default). Ensure it contains your file with the same content you entered locally.
hint : Lost in your commits ? use git log or git log --graph --oneline to print the commit tree.
    
    git branch
    git push -u origin PierrickPINPIN


## **Exercise 3: Merge simple changes**

Using only the shell :
### 1. Merge your branch into the 'master' branch.
    git merge PierrickPINPIN

### 2. Push your changes in the 'master' branch to the remote repository.
hint : You may have to merge or rebase on the changes from your teammates.
Check in the web UI you see your own file in the 'master' branch. Ensure it contains the same content you entered locally.

    git push -u origin master



## **Exercise 4: Resolve merge conflicts**

For the repository owner... In the web UI, make sure lines 2 to 6 of the README.md are not empty.
One person at a time, using only the shell :

### 1. Switch back to your own branch (not including the latest changes from the master branch).
    git checkout PierrickPINPIN

### 2. Edit the lines 2 to 6 of the README.md file with a text you like (a poem, a quote, some clever code...). It can be any readable text, it may be incomplete, it must just take about 5 lines and be different from your teammates. It must start on line 2 to trigger conflicts between team members.
    nano README.md
    
    #nano script:
    "The night is darkest just before the dawn. And I promise you, the dawn is coming."
    "I believe what doesn't kill you simply makes you, stranger."
    "Endure, Master Wayne. Take it. They'll hate you for it, but that's the point of Batman, he can be the outcast. He can >"Your anger gives you great power. But if you let it, it will destroy you... As it almost did me."
    "You either die a hero or live long enough to see yourself become the villain."
    "If you're good at something, never do it for free."

### 3. Commit this change.

    git add README.md
    git commit -m "Updated README.md lines 2 to 6"

### 4. Pull latest status from the remote repository 'master' branch into your local 'master' branch.
    git pull origin master #fatal: couldn't find remote ref master
    git branch -r
    git pull origin main 

### 5. Merge your branch into the local 'master' branch.
    git checkout main
    git merge PierrickPINPIN

### 6. If there are conflicts, we want the paragraph to appear in alphabetical order in the final README.md file.
    hint: You have divergent branches and need to specify how to reconcile them.
    hint: You can do so by running one of the following commands sometime before
    hint: your next pull:
    hint:
    hint:   git config pull.rebase false  # merge (the default strategy)
    hint:   git config pull.rebase true   # rebase
    hint:   git config pull.ff only       # fast-forward only
    hint:
    hint: You can replace "git config" with "git config --global" to set a default
    hint: preference for all repositories. You can also pass --rebase, --no-rebase,
    hint: or --ff-only on the command line to override the configured default per
    hint: invocation.

### 7. Push your changes in the 'master' branch to the remote repository.
hint : You may edit the README.md file using nano or vim in shell, nano may be easier as it displays available commands at the bottom.
Check the README.md content in the web UI. After everyone in the group made their change and resolved conflicts, the file in 'master' branch should contain one paragraph per team member.

    git push origin main



## **Exercise 5: Take latest changes from master in local branch**

For the repository owner... In the web UI, add a line of text at the beginning of the README.md with the team members' names or aliases.
Using only the shell in your local repository :

### 1. Pull the latest changes in the 'master' branch, check the README.md is up-to-date (contains all the paragraphs and the new line).
    git pull origin main

#From https://github.com/gabriel-bar-linux/td-group-gith-branch
* branch            main       -> FETCH_HEAD
fatal: Not possible to fast-forward, aborting.

    git fetch origin main

### 2. Switch back to your own branch (not including the latest changes from the master branch).
    cat README.md

### 3. Merge the changes from 'master' to your own branch.

    git checkout PierrickPINPIN
    git merge main

    git add README.md
    git commit -m "Merge changes from master branch"
    git push -u origin PierrickPINPIN

### 4. Commit this change.
Check the README.md content in the web UI. After everyone in the group made their change and resolved conflicts, the file in 'master' branch should contain one paragraph per team member.



## **Exercise 6: Delete a branch**

Using only the shell in your local repository :

### 1. Delete your branch on local repository.
    git checkout main
    git branch -d PierrickPINPIN 

### 2. Delete your branch on distant repository.
Using the web UI, ensure only the 'master' branch remains.

    git push origin --delete PierrickPINPIN



## **Exercise 7: Rebase interactively to have a clean history**

Using only the shell in your local repository :

### 1. Pull the latest changes in the 'master' branch.
    git pull origin main

### 2. Create a new local branch named after you and switch to it.
    git branch PierrickPINPIN
    git checkout PierrickPINPIN

### 3. Then with a separate commit for each change :
(a) Clear the whole file, removing all text.

    > README.md
    git add README.md
    git commit -m "Update README.md 1"

(b) Add a title line "Git interactive rebase".
    
    nano README.md
    # Git interactive rebase
    git add README.md
    git commit -m "Update README.md 2"

(c) Copy the first paragraph from https://git-scm.com/book/en/v2/GitTools-Rewriting-History.

    nano README.md
    The entire Pro Git book, written by Scott Chacon and Ben Straub and published by Apress, is available here. All content is licensed under the Creative Commons Attribution Non Commercial Share Alike 3.0 license. Print versions of the book are available on Amazon.com.
    git add README.md
    git commit -m "Update README.md 3"

(d) Add the second paragraph from the same page.

    nano README.md
    The version found here has been updated with corrections and additions from hundreds of contributors. If you see an error or have a suggestion, patches and issues are welcome in its GitHub repository.
    git add README.md
    git commit -m "Update README.md 4"

(e) Add the first and second paragraphs from the "Changing Multiple Commit Messages" section in the same page.

    nano README.md
    At this point, you should have a bona fide Git repository on your local machine, and a checkout or working copy of all of its files in front of you. Typically, you'll want to start making changes and committing snapshots of those changes into your repository each time the project reaches a state you want to record.
    git add README.md
    git commit -m "Update README.md 5"

(f) Remove the second paragraph from your file.

    nano README.md
    git add README.md
    git commit -m "Update README.md 6"

(g) Add the missing title "Changing Multiple Commit Messages" on a line just before the two paragraphs your copied (before To modify a commit that is farther back in your history...).

    nano README.md
    Changing Multiple Commit Messages
    git add README.md
    git commit -m "Update README.md 7"

(h) Add a final line with your name or alias.
The commit history of your branch should then be a bit messy with 8
commits.

    nano README.md
    PierrickPINPIN
    git add README.md
    git commit -m "Update README.md 8"

### 4. Use interactive rebase to have a single commit with message "Explain git interactive rebase.".
    git rebase -i HEAD~8 
    #8 last commits

    #Delete all except the first line
    #Conflict:
    pierrick@Cadmium-X:~/td-group-gith-branch$ git rebase -i HEAD~8
    Auto-merging README.md
    CONFLICT (content): Merge conflict in README.md
    error: could not apply c90a58d... Update README.md 8
    hint: Resolve all conflicts manually, mark them as resolved with
    hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
    hint: You can instead skip this commit: run "git rebase --skip".
    hint: To abort and get back to the state before "git rebase", run "git rebase --abort".

### 5. Push your branch on the remote repository.
hint : You can change Git default editor with command git config -global core.editor "path to editor". By default it uses nano.
Using the web UI, check the README.md content in your branch on the remote repository. Check the your branch history or graph, it should only contain the aggregated commit you pushed, not all the local commits. The 'master' branch should not have changed.

    git push -u origin PierrickPINPIN



### Exercise 8: Create and approve a Merge/Pull Request

In the web UI open your branch then
- In GitLab click on 'Create merge request' to create a Merge Request to merge your branch into the 'master' branch.
- In GitHub click on 'pull request' to create a Pull Request to merge your branch into the 'master' branch.
- Ask another team member to check there is a single commit and merge the Merge/Pull Request.
hint : As multiple people will try to change the same file, you may well have
conflicts. In that case you have to rebase your branch on the latest state of the
'master' branch, resolving potential conflicts, and push it again. Reloading the
merge/pull request webpage will update it.


## You can retrieve this work on:
https://github.com/gabriel-bar-linux/td-group-gith-branch