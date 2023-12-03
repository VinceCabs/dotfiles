@echo off

set TARGET_PATH=%USERPROFILE%\Downloads\youtube-dl

c:
cd %TARGET_PATH%
set /p URL="enter video's URL : "

@echo on
yt-dlp  --no-check-certificate --format mp4 --output "%%(title)s.%%(ext)s" %URL%

PAUSE