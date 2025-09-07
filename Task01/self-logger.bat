@echo off
REM Настройка базы
set DB=database.db
set table=user_table

REM Создать таблицу, если она не существует
sqlite3 %DB% "CREATE TABLE IF NOT EXISTS %table% (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, date TEXT);"
echo Имя программы: %PROGRAM_NAME%
for /f %%A in ('sqlite3.exe %DB% "SELECT COUNT(*) + 1 FROM %table%;"') do ( set RUN_COUNT=%%A )
echo Количество запусков: %RUN_COUNT%
for /f "delims=" %%A in ('sqlite3.exe %DB% "SELECT MIN(date) FROM %table%;"') do ( set FIRST_RUN=%%A )
echo Первый запуск: %FIRST_RUN%

REM Вставить текущего пользователя с текущей датой
sqlite3 %DB% "INSERT INTO %table% (name, date) VALUES ('%USERNAME%', strftime('%%Y-%%m-%%d %%H:%%M', 'now'));"
REM Вывести заголовок
sqlite3 %DB% "SELECT printf('%%-*s| %%s', (SELECT MAX(LENGTH(name)) FROM %table%), 'User', 'Date');"
REM Вывести линию-разделитель
sqlite3 %DB% "SELECT replace(printf('%%*s', (SELECT MAX(LENGTH(name)) FROM %table%) + (SELECT MAX(LENGTH(date)) + 2 FROM %table%), ''), ' ', '-');"
REM Вывести все записи
sqlite3 %DB% "SELECT name, date FROM %table%;"
REM Вывести линию-разделитель
sqlite3 %DB% "SELECT replace(printf('%%*s', (SELECT MAX(LENGTH(name)) FROM %table%) + (SELECT MAX(LENGTH(date)) + 2 FROM %table%), ''), ' ', '-');"
pause