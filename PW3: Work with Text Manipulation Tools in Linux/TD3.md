# **TD3/9: Work with text manipulation tools in Linux**

## **Exercise 1: Grep and awk on tabular data**

### 1. Display the list of files and folders at the root using ls -l
    ls -l

### 2. In a pipeline (using |), append a grep instruction to only display informations of bin
    ls -l / | grep bin

### 3. Append an awk instruction to only display the size of bin
    ls -lh | grep bin | awk '{print $5}'

### 4. Now rather extract the month, day and year of creation of the folder bin
    ls -lh | grep bin | awk '{print $6, $7, $8}'

### 5. Now rearrange the instruction to get the following output format : 2020-Oct-26 (from original data : Oct 26 2020)
    ls -lh | grep bin | awk '{print $8"-"substr($6,1,3)"-"$7}'



## **Exercise 2: Grep with Regex, and sed on unstructured data**

### 1. Run the following command :
    curl https://en.wikipedia.org/wiki/List_of_cyberattacks > cyberattacks.txt

### 2. Use grep to extract all the lines that contain the keyword "meta"
    grep -E 'meta' cyberattacks.txt

<meta charset="UTF-8"/>
<meta name="ResourceLoaderDynamicStyles" content=""/>
<meta name="generator" content="MediaWiki 1.40.0-wmf.22"/>
<meta name="referrer" content="origin"/>
<meta name="referrer" content="origin-when-crossorigin"/>
<meta name="referrer" content="origin-when-cross-origin"/>
<meta name="robots" content="max-image-preview:standard"/>
<meta name="format-detection" content="telephone=no"/>
<meta name="viewport" content="width=1000"/>
<meta property="og:title" content="List of cyberattacks - Wikipedia"/>
<meta property="og:type" content="website"/>


### 3. Now only extract "meta" and the first following word. You might use grep options to enable the use of regex (Regular Expressions) 
    grep -Eo 'meta\s+\w+' cyberattacks.txt

meta charset
meta name
meta name
meta name
meta name
meta name
meta name
meta name
meta name
meta property
meta property
meta property

### 4. Only extract the follwing word (but not the keyword "meta")
    grep -Eo 'meta\s+\w+' cyberattacks.txt | awk '{print $2}'

name
name
name
name
name
name
name
name
property
property
property

### 5. Let’s now try more interesting (yet complex) patterns. You might use vim to open the file and look for useful patterns. Let’s extract the introduction
- We could ask grep to catch the paragraph corresponding to a sentence that is only present in the introduction. Try to run the following command cat cyberattacks.txt | grep -P ’A cyberattack is’
- This does not work since the source code is here different from what is visible on the web page. Now try the following : cat cyberattacks.txt | grep -P ’A <a href="/wiki/Cyberattack" title="Cyberattack">cyberattack</a> is any type’
- It is now working, but what if the text evolves over time ? Try the following instead : cat cyberattacks.txt | grep -A1 ’mw-content-text’ | grep -v ’mw-content-text’. This is based on the text above that seems to be more stable.

        cat cyberattacks.txt | grep -P "A cyberattack is"
        cat cyberattacks.txt | grep -P "A <a href="/wiki/Cyberattack" title="Cyberattack">cyberattack</a> is any type"
        cat cyberattacks.txt | grep -A1 "mw-content-text" | grep -v "mw-content-text"

### 6. Your turn
- Extract the tab title
- Make a list of cyber attacks based on section titles

        cat cyberattacks.txt | grep -oP "(?<=<title>).*?(?=<\/title>)" cyberattacks.txt
    List of cyberattacks - Wikipedia

        cat cyberattacks.txt | grep -oP '(?<=<span class="mw-headline" id=")[^"]+(?=">)'

- Indiscriminate_attacks
- Destructive_attacks
- Cyberwarfare
- Government_espionage
- Corporate_espionage
- Stolen_e-mail_addresses_and_login_credentials
- Stolen_credit_card_and_financial_data
- Blockchain_and_cryptocurrencies
- Stolen_medical-related_data
- Ransomware_attacks
- Hacktivism
- See_also
- References


