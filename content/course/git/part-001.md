---
title: "Initialisierung eines lokalen Repositories"
linkTitle: Repository anlegen
type: book
date: '2021-09-13'
tags:
- Git
- MVHS
weight: 20
---

> Als ein **Repository** bei **git** wird ein Ordner bezeichnet, der unter Versionskontrolle von git steht.

## Ordner anlegen

Als erstes legen wir einen Ordner an, den wir gleich unter die Versionsverwaltung stellen wollen. Aktuell werden wir es mit einen leerern ordner tun, das gleiche lässt sich aber auch mit einen vorhandenen Ordner erledigen, wenn Sie desen Inhalt versionieren wollen.

Wechseln Sie in den neu erzeugten Ordner.

```bash
# Linux / macOS
$ mkdir repo_1
$ ls -la
repo_1
$ cd repo_1
```

```pwsh
# Windows (Power Shell Core)
> mkdir repo_1

    Directory: C:\Users\kurse\src

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----          15.09.2021    08:05                repo_1
> cd repo_1
> 
```

## Repository initialisieren
 
Nun initialisieren wir ein git Repository mit dem `init` Befehl von git.

```bash
# Linux / macOS
$ git init
Initialized empty Git repository in /Users/kurse/src/repo_1/.git/
$ ls -la
total 0
drwxrwxrwx 1 eugen eugen 4096 Sep 15 08:10 .
drwxrwxrwx 1 eugen eugen 4096 Sep 15 08:05 ..
drwxrwxrwx 1 eugen eugen 4096 Sep 15 08:10 .git
```

```pwsh
# Windows (Power Shell Core)
> git init
Initialized empty Git repository in C:/Users/kurse/src/repo_1/.git/
> Get-ChildItem . -Force

    Directory: C:\Users\kurse\src\repo_1

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d--h-          15.09.2021    08:12                .git
```

Dabei wird das Verzeichnis unter Versionskontrolle gestellt. Das ist an dem versteckten Ordner `.git` gut zu sehen. In diesem werden alle Informationen zu den Versionen gespeichert.

## Prüfen des Repository Zustandes

Den aktuellen Zustand des Ordners, aus Sicht von git, können wir mit dem Befehl `status` abrufen. Dieser zeigt, ob neue Dateien zu der Versionsverwaltung hinzugefügt werden können, ob geänderte Dateien vorliegen usw.

```bash
# Linux / macOS
repo_1$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
repo_1$
```

```powershell
# Windows
repo_1> git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
repo_1>
```

Bei einem neu angelegten Repository ist der Status natürlich sehr sauber. Es sind ja noch keine Dateien versioniert und es liegen auch noch keine zum Versionieren vor.