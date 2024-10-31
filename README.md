# Birtdate changer
this is script for changing birth date of file/directory

# How to use
`{path_of_script}./birth_date_changer.sh {DDMMYYY_HHMMSS} {file_name}`

## How to know your path?
`pwd`

## How to add alias?
in your `~/.bashrc` add line: `alias bdate="{path_of_script}./birth_date_changer.sh"`

## Example
Your current directory `pwd` = /home/user/Downloads<br>
Downloaded repo = /home/user/repos/birthbirtdate_modifier<br>
Use `stat` on test.txt to check file birhdate<br>
You shoul see output like this:
```
File: test.txt
Access: 2024-10-31 16:12:09.588566253 +0500
Modify: 2024-10-31 16:12:07.505003363 +0500
Change: 2024-10-31 16:12:07.505003363 +0500
 Birth: 2024-10-31 16:12:07.505003363 +0500
```
Type `/home/user/repos/birthbirtdate_modifier./birth_date_changer.sh 10102010_123456 test.txt`<br>
Or if you using alias `bdate 10102010_123456 test.txt` 