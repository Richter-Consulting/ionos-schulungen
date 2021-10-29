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

Git bietet für solche Dateien zwei Orten, in denen die Ausnahmen definiert werden können. Wir können die Ausnahmen global (auf Benutzerebene) definieren, oder pro Repository.

Um eine neue Ausnahmedatei für den Benutzer anzulegen, geben Sie folgendes ein:

```bash
# Linux / macOS
repo_1$ git config --global core.excludesfile ~/.gitignore_global
```

```powershell
# Winfows
repo_1> git config --global core.excludesfile "$env:USERPROFILE\.gitignore_global"
```
Nun kann die betreffende Datei `.gitignore_global` erstellt werden und in dieser die Liste der globalen Ausnahmen gepflegt werden. Fügen Sie in unserem Fall einfach folgendes als erste Zeile in die Datei ein:

```
# Ignore global temporal files
*.bak
```

Die Zeilen, die mit `#` Anfangen, werden als Kommentare ausgewertet.

Eine sehr gute Übersicht über übliche Ausnahmen liefert die Seite https://github.com/github/gitignore. Im Verzeichnis `Global` sind dabei die globalen Ausnahmen für unterschiedliche Betriebssysteme (z.B. bei macOS ist es üblich die Datei `.DS_Store` auszufiltern, oder unter Windows `Thumbs.db`).

Pro Zeile in der Datei wird eine Ausnahme definiert, die auch Globings (Platzhalter) erlaubt.

- `*`: Beliebiges Zeichen, beliebige Anzahl
- `**`: Beliebige Unterverzeichnisse
- `?`: Ein Zeichen
- `[Aa]`: Regex für kleines/großes A

Nach dem Hinzufügen der oberen Ausnahme, können wir wieder mit `git status` unsere Bemühungen überprüfen.

```bash
# Linux / macOS
repo_1$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        kapitel_1.~

nothing added to commit but untracked files present (use "git add" to track)
```

Nun wir die Datei `kapitel_1.bak` nicht mehr angezeigt.

## Ausnahmen im Repository

