# yt-dlp

[Official doc](https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#usage-and-options)

Update

`yt-dlp --update`

Download playlist into MP4:

`yt-dlp --format mp4 --ignore-errors --concurrent-fragments 4 --restrict-filenames --yes-playlist --output "%(playlist)s/%(playlist_index)s-%(title)s.%(ext)s" --windows-filenames <URL>`

Use a list of URLs in a file:

`--batch-file <URLS_FILE>`

Only videos over a minute:

`--match-filter "duration>59`
