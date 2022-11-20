# Git

[Git Cheat Sheet](https://about.gitlab.com/images/press/git-cheat-sheet.pdf)

## Personal aliases

Alias [.gitconfig](https://github.com/VinceCabs/dotfiles/blob/master/.gitconfig#L15)

## Commands

### Commits

Cancel last commit and keep changes in working directory

```sh
git reset --soft HEAD^
```

Cancel last commit by reassigning `master` to previous commit

```sh
git branch -f master HEAD^
# OR
git reset HEAD^  # /!\ commit is lost
```

Cancel changes on a file

```sh
git restore README.md  # remove changes from working directory
git restore --staged README.md # unstage this file (eq to git reset HEAD -- README.md)
```

Squash last 2 commits

```sh
git reset --soft HEAD~2
```

Interactive stage

```sh
$ git add -i
           staged     unstaged path
  1:    unchanged        +0/-1 TODO
  2:    unchanged        +1/-1 index.html
  3:    unchanged        +5/-1 lib/simplegit.rb
```

### Log & diff

Git log with stats

```sh
git log --stat
```

Log for a file with content of each change (diff, `-p` like 'patch')

```sh
git log -p -- README.md
```

Deltas between references

```sh
$ git log origin/master..HEAD  # Commits dans Head non atteignables par origin master (c'est ce qui va être push aussi)
$ git log refA refB --not refC  # Dans refA et refB non atteignable par refC
$ git log --left-right master...experiment  # Commits not in common. (Left= master branch in this example)
< F
< E
> D
$ git log refA refB --not refC
$ git log --left-right master...experiment
< F
< E
> D
```

Diffs

```sh
git diff --staged  # stage vs HEAD
git diff   # working vs HEAD
git diff --check  # Check if no spaces, etc. (errors)
```

Short git status 

```sh
$ git status -s
 M README
MM Rakefile
A  lib/git.rb
```

Lister le contenu du stash, prendre l'avant-dernier puis tout vider

```sh
$ git stash list
$ git stash show 1
samples/robot_variables.py    | 1 +
samples/test_home_engie.robot | 3 ++-
$ git stash drop
```

Save local changes to stash with a message

```sh
git stash push -m "working on this file"
git stash save "working on this file"  # same
```

Historique local

```sh
$ git reflog
734713b HEAD@{0}: commit: Fix refs handling, add gc auto, update tests
d921970 HEAD@{1}: merge phedders/rdocs: Merge made by the 'recursive' strategy.
1c002dd HEAD@{2}: commit: Add some blame and merge stuff
1c36188 HEAD@{3}: rebase -i (squash): updating HEAD
```

### branches & merges

Pousser la branche actuelle sur une nouvelle branche remote en upstream

```sh
git push -u origin HEAD
```

Supprimer les branches locales qui n'existent plus en remote

```sh
git fetch --prune
```

Supprimer les branches déjà mergées

```sh
!git branch --merged | grep -v \"\\*\" | xargs -n 1 git branch -d
```

Faire un merge sous la forme d'un seul commit

```sh
git merge --squash <feature branch>
git commit -m "pouet galipette"
```

récupérer la branche précédente

```sh
git checkout -
```

lister les fichiers différents entre 2 branches

```sh
git diff --name-only previsions
```

renommer une branche

```sh
git branch -m [<oldname>] <newname>
```

renommer une branche sur remote

```sh
git branch -m old_branch new_branch         # Rename branch locally
git push origin :old_branch                 # Delete the old branch
git push --set-upstream origin new_branch   # Push the new branch, set local branch to track the new remote
```

voir un fichier sur une autre branche

```sh
git show branche:src/fichier.py
```

### Internals Git

Stocke les identifiants pour éviter de retaper login pwd à chaque fois

```sh
git config --global credential.helper store
```

Ouvrir une page d'aide pour une commande donnée

```sh
git help <commande>
```
