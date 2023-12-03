@echo off

set TARGET_PATH=%USERPROFILE%\Downloads\youtube-dl

c:
cd %TARGET_PATH%
set /p URL="enter video's URL : "

@echo on
yt-dlp  --no-check-certificate --extract-audio --audio-format mp3 --ignore-errors -o "%%(title)s.%%(ext)s" %URL%

PAUSE