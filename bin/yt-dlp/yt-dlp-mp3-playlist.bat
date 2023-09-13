@echo off

set TARGET_PATH=%USERPROFILE%\Downloads\youtube-dl

c:
cd %TARGET_PATH%
set /p URL="enter video's URL : "

@echo on
yt-dlp.exe --extract-audio --audio-format mp3 --ignore-errors --yes-playlist -o "%%(playlist)s/%%(playlist_index)s - %%(title)s.%%(ext)s" %URL%

PAUSE