# Birtdate changer
this is script for changing birth date of file/directory

# How to use
for linux `{path_of_script}./birth_date_changer.sh {DDMMYYY_HHMMSS} {file_name}`<br>
for windows `{path_of_script}.\ChangeCreationTime.ps1 -DateTime "YYYY-MM-DD HH:MM:SS" -FileName "{path_to_file}"`<br>
if it's on windows<br>
add `-Recurse` for directory<br>
add filename to -FileName argument after path to file for files

## How to know your path?
`pwd` 

## How to add alias on linux?
in your `~/.bashrc` add line: `alias bdate="{path_of_script}./birth_date_changer.sh"`

## Example on Linux
Your current directory `pwd` = /home/user/Downloads<br>
Downloaded repo = /home/user/repos/birthbirtdate_modifier<br>
Use `stat test.txt` on linux to check file birhdate<br>
You should see output like this:
```
File: test.txt
Access: 2024-10-31 16:12:09.588566253 +0500
Modify: 2024-10-31 16:12:07.505003363 +0500
Change: 2024-10-31 16:12:07.505003363 +0500
 Birth: 2024-10-31 16:12:07.505003363 +0500
```
Type `/home/user/repos/birthbirtdate_modifier./birth_date_changer.sh 10102010_123456 test.txt`<br>
Or if you using alias `bdate 10102010_123456 test.txt`<br>

## Example on Windows
Downloaded repo = C:\Users\repos\birthbirtdate_modifier<br>
Open this folder, click on empty space and select cmd<br>
Type for file `.\ChangeCreationTime.ps1 -DateTime "2024-01-29 12:00:00" -FileName "C:\Users\test.txt"`<br>
Type for folder `.\ChangeCreationTime.ps1 -DateTime "2024-01-29 12:00:00" -FileName "C:\Users\test" -Recurse`<br>