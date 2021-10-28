---
title: "Asunahmen für Versionierung"
linkTitle: Ausnahmen
type: book
date: '2021-10-26'
tags:
- Git
- MVHS
weight: 50
---

Es kommt oft vor, das in dem Ordner nicht nur Dateien liegen, die versioniert werden sollen, sondern auch andere (eventuell temporäre) Dateien. Bei der Software-Entwicklung sind es zum Beispiel die kompilierten Binärdateien, oder auch sehr viele temporäre. Auch Office hinterlegt oft temporäre Dateien, wenn man das Original bearbeitet.

Legen wir eine temporäre Datei an, die wir nicht in der Versionsverwaltung haben wollen, zum Beispiel mit dem Namen `kapitel_1.~` und `kapitel_1.bak`.

```bash
# Linux / macOS
repo_1$ touch kapitel_1.~ kapitel_1.bak
repo_1$ ls
kapitel_1.bak  kapitel_1.txt  kapitel_1.~
```

```powershell
# Windows
repo_1> New-Item -ItemType File -Path "kapitel_1.~", "kapitel_1.bak"

    Directory: C:\Users\kurs\src\repo_1

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          28.10.2021    08:50              0 kapitel_1.~
-a---          28.10.2021    08:50              0 kapitel_1.bak
```

Wenn wir jetzt `git status` aufrufen, sehen wir zwei noch nicht versionierte Dateien. Das wollen wir eigentlich nicht sehen, da diese Dateien uns nicht interessieren.

```bash
# Linux / macOS
repo_1$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        kapitel_1.bak
        kapitel_1.~

nothing added to commit but untracked files present (use "git add" to track)
```

## Globale Ausnahmen (Betriebssystem)

## Ausnahmen im Repository