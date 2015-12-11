git pull
@xcopy /S  /-Y E:\src\* src\* /EXCLUDE:copy.txt
git add .
git commit -m "update"
git push origin master
pause
