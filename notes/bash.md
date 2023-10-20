# Bash

# Alias

Alias [.bashrc](https://github.com/VinceCabs/dotfiles/blob/master/.bashrc#L11)

## Shortcuts

<kbd>Ctrl</kbd>+<kbd>r</kbd> : search history (<kbd>Enter</kbd> to run, → to edit command)

<kbd>Ctrl</kbd>+<kbd>u</kbd>: delete from current cursor back to the start of the line

<kbd>Ctrl</kbd>+<kbd>l</kbd> : clear screen

## File system

Disk space:

```sh
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
rootfs          128G   92G   37G  72% /
none            128G   92G   37G  72% /dev
...
```

Usage:

```sh
$ du -h --max-depth=1
12K     ./d
4.0K    ./c
20K     .
```

`top` / `htop` : all currently-running processes and their owners with memory usage

`ln -s /path/to/file-name link-name` : simbolic link

`sudo su -`: switch to root

```sh
$ tree -L 2
.
|-- a
`-- d
    `--e
```

`locate`, `find`: first one uses an index.

## Env variables

List variables

`env`

Create a variable:

`export SOME_VARIABLE=some-value`

Print variable:

```sh
$ echo $SOME_VARIABLE
some-value
```

`"` will do variable substitution, `'` will not:

```sh
$ var='Hello'
$ echo '$var world!'
$var world!
$ echo "$var world!"
Hello world!
```

## Install, open

`apt search`, `apt install`

Download, unzip, untar:

```sh
$ wget https://github.com/atom/atom/releases/download/v1.35.0-beta0/atom-amd64.tar.gz
$ gunzip atom-amd64.tar.gz && ls
atom-amd64.tar
$ tar -xf atom-amd64.tar && ls
atom-beta-1.35...
```

`xdg-open` open file with default app

## Standard streams

`0`: stdin
`1`: stout
`2`: stderr

```sh
$ printf "1\n3"
1
3
```

File to command `<`:

```sh
$ printf "2\n1" > file && sort < file
1
2
```

Write to stdout, stderr:

```sh
$ cat test
echo "stdout" >&1
echo "stderr" >&2
$ ./test
stderr
stdout
$ ./test 1>/dev/null
stderr
$ ./test 2>/dev/null
stdout
$ ./test &>/dev/null
$ echo "test" | tee file1 file2 file3 && ls
test
file0  file1  file2  file3
```

```sh
$ echo 'one two three' | xargs mkdir
$ ls
one two three
```

[More `xargs`](https://shapeshed.com/unix-xargs/)

## ssh

Connect, copy

```sh
$ ssh –p <port> andrew@137.xxx.xxx.89
$ scp –P <port> hello andrew@137.xxx.xxx.89:~
hello        100%
# /!\ -P and not -p
```

## Other

`crontab -e` : edit crontab

`echo $(date) pouet pouet >> /tmp/custom_log` : log msg

`echo $?`: print last exit code

`sudo !!`, `!!`: last command

`grep -i <search_term>`: make case insensitive

`cd`: idem que `cd ~`

`cd xx; pwd`, `cd xx && pwd`: chain commands

Get my public IP:

```sh
$ curl https://api.myip.com
{"ip":"xx.xx.xxx.xxx","country":"France","cc":"FR"}:
```

## Scripting

Shebang:

```bash
#!/usr/bin/env bash
```

Command substitution `$()`:

```bash
$ var=$( ls ~ | wc -l )
$ echo &var
34
```

Variable substitution `$` or `${}`:

```bash
$ var="pouet"
$ echo "$var and ${var}ttt"
pouet and pouetttt
```
