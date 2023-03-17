# yt-dlp

Update

`yt-dlp --update`

Download playlist into MP4:

`yt-dlp --format mp4 --ignore-errors --concurrent-fragments 4 --restrict-filenames --yes-playlist --output "%(playlist)s/%(playlist_index)s-%(title)s.%(ext)s" --windows-filenames <URL>`

Use a list of URLs in a file:

`--batch-file <URLS_FILE>`

Only videos over a minute:

`--match-filter "duration>59`
