---
title: "Ausnahmen für Versionierung"
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
PS repo_1> New-Item -ItemType File -Path "kapitel_1.~", "kapitel_1.bak"

    Directory: C:\Users\kurs\src\repo_1

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          28.10.2021    08:50              0 kapitel_1.~
-a---          28.10.2021    08:50              0 kapitel_1.bak
```

Wenn wir jetzt `git status` aufrufen, sehen wir zwei noch nicht versionierte Dateien. Das wollen wir eigentlich nicht sehen, da diese Dateien uns nicht interessieren.

```bash
repo_1$ git status
On branch main
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        kapitel_1.bak
        kapitel_1.~

nothing added to commit but untracked files present (use "git add" to track)
```

## Globale Ausnahmen (Betriebssystem)

Git bietet für solche Dateien zwei Orte, in denen die Ausnahmen definiert werden können. Wir können die Ausnahmen global (auf Benutzerebene) definieren, oder pro Repository.

Um eine neue Ausnahmedatei für den Benutzer anzulegen, geben Sie Folgendes ein:

```bash
# Linux / macOS
repo_1$ git config --global core.excludesfile ~/.gitignore_global
repo_1$ touch ~/.gitignore_global
```

```powershell
# Winfows
PS repo_1> git config --global core.excludesfile "$env:USERPROFILE\.gitignore_global"
PS repo_1> New-Item "$env:USERPROFILE\.gitignore_global"

    Directory: C:\Users\kurs

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          11.11.2021    19:47              0 .gitignore_global
```
Nun kann in die betreffende Datei `.gitignore_global` die Liste der globalen Ausnahmen gepflegt werden. Fügen Sie in unserem Fall einfach Folgendes als erste Zeilen in die Datei ein:

```ini
# Ignore global backup files
*.bak
```

Die Zeilen, die mit `#` Anfangen, werden als Kommentare ausgewertet.

Eine sehr gute Übersicht über übliche Ausnahmen liefert die Seite [github.com/github/gitignore](https://github.com/github/gitignore). Im Verzeichnis `Global` sind dabei die globalen Ausnahmen für unterschiedliche Betriebssysteme (z.B. bei macOS ist es üblich die Datei `.DS_Store` auszufiltern, oder unter Windows `Thumbs.db`).

Pro Zeile in der Datei wird eine Ausnahme definiert, die auch Globings (Platzhalter) erlaubt.

- `*`: Beliebiges Zeichen, beliebige Anzahl
- `**`: Beliebige Unterverzeichnisse
- `?`: Ein Zeichen
- `[Aa]`: Regex für kleines/großes A
- `!abc`: Mit `!` kann die Ausnahme umgekehrt werden (zum Beispiel alles im Ordner `XYZ` nicht versionieren, aber die Datei `abc.md`)

Nach dem Hinzufügen der oberen Ausnahme können wir wieder mit `git status` unsere Bemühungen überprüfen.

```bash
repo_1$ git status
On branch main
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        kapitel_1.~

nothing added to commit but untracked files present (use "git add" to track)
```

Nun wir die Datei `kapitel_1.bak` nicht mehr angezeigt.

## Ausnahmen im Repository

Die Ausnahmen für ein konkretes Repository werden in der Datei `.gitignore` definiert. Meistens wird diese Datei in die Versionsverwaltung aufgenommen, da diese Ausnahmen das konkrete Projekt betreffen und für alle Beteiligten relevant sind.

Die Datei `.gitignore` gilt dabei für das aktuelle Verzeichnis und alle Unterverzeichnisse. Unterverzeichnisse können dabei eigene Ausnahmen in eigenen `.gitignore` Dateien definieren, die die Ausnahmen aus den übergeordneten Verzeichnissen ergänzen.

Legen Sie nun die `.gitignore` Datei im Wurzelverzeichnis von unserem Repository.

```bash
# Linux / macOS
repo_1$ touch .gitignore
```

```powershell
# Windows
PS repo_1> New-Item .gitignore

    Directory: C:\Users\kurs\src\repo_1

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          11.11.2021    19:53              0 .gitignore
```

Fügen Sie in die neue Ausnahmedatei folgende Zeilen, um unsere `.~` Datei von der Versionsverwaltung auszuschließen.

```ini
# Exclude temporal files
*.~
```

Mit `git status` sehen wir nun, dass auch die `.~` Datei in der Auflistung nicht mehr auftaucht, dafür aber unsere neue `.gitignore` Ausnahmedatei. Diese sollen wir versionieren.

```bash
repo_1$ git status
On branch main
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        .gitignore

nothing added to commit but untracked files present (use "git add" to track)
```

```bash
repo_1$ git add .gitignore
repo_1$ git commit -m "Add repo ignore file for temp files"
[main d8f7b79] Add repo ignore file for temp files
 1 file changed, 1 insertion(+)
 create mode 100644 .gitignore
```

Auf der bereits erwähnten [GitHub Seite](https://github.com/github/gitignore) finden Sie eine Sammlung von Ausnahmedateien für unterschiedliche Projekte (Programmiersprachen / Tools). Sie müssen damit die Ausnahmelisten nicht selbst erstellen, sondern von dieser Seite die vorhandenen als Ausgangsbasis für eigene Projekte nutzen.