@echo off
REM ����ன�� ����
set DB=database.db
set table=user_table

REM ������� ⠡����, �᫨ ��� �� �������
sqlite3 %DB% "CREATE TABLE IF NOT EXISTS %table% (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, date TEXT);"
echo ��� �ணࠬ��: %PROGRAM_NAME%
for /f %%A in ('sqlite3.exe %DB% "SELECT COUNT(*) + 1 FROM %table%;"') do ( set RUN_COUNT=%%A )
echo ������⢮ ����᪮�: %RUN_COUNT%
for /f "delims=" %%A in ('sqlite3.exe %DB% "SELECT MIN(date) FROM %table%;"') do ( set FIRST_RUN=%%A )
echo ���� �����: %FIRST_RUN%

REM ��⠢��� ⥪�饣� ���짮��⥫� � ⥪�饩 ��⮩
sqlite3 %DB% "INSERT INTO %table% (name, date) VALUES ('%USERNAME%', strftime('%%Y-%%m-%%d %%H:%%M', 'now'));"
REM �뢥�� ���������
sqlite3 %DB% "SELECT printf('%%-*s| %%s', (SELECT MAX(LENGTH(name)) FROM %table%), 'User', 'Date');"
REM �뢥�� �����-ࠧ����⥫�
sqlite3 %DB% "SELECT replace(printf('%%*s', (SELECT MAX(LENGTH(name)) FROM %table%) + (SELECT MAX(LENGTH(date)) + 2 FROM %table%), ''), ' ', '-');"
REM �뢥�� �� �����
sqlite3 %DB% "SELECT name, date FROM %table%;"
REM �뢥�� �����-ࠧ����⥫�
sqlite3 %DB% "SELECT replace(printf('%%*s', (SELECT MAX(LENGTH(name)) FROM %table%) + (SELECT MAX(LENGTH(date)) + 2 FROM %table%), ''), ' ', '-');"
pause