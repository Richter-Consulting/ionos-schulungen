---
title: "Historie anzeigen lassen"
linkTitle: Historie anzeigen
type: book
date: '2021-09-27'
tags:
- Git
- MVHS
weight: 40
---

Die Historie eines Repositorys kann über den Befehl `log` angesehen werden. Dieser gibt eine sehr ausführliche Information über alle gemachten Commits. Der Befehl hat viele Parameter und kann sehr gut angepasst werden (was wir später noch nutzen werden).

```bash
repo_1$ git log
commit 221df61c6e0b69af839d95efff837ecebf7e443f (HEAD -> main)
Author: Eugen [WebDucer] Richter <kurse@richter.consulting>
Date:   Tue Sep 21 08:06:48 2021 +0200

    feat: Start des ersten Kapitels
```

### Verkürzte Anzeige der Historie

Wenn die Anzahl der Commits steigt, wird die _ausführliche_ Ausgabe der Historie sehr unübersichtlich. Mit dem Parameter `--pretty=oneline` kann die Ausgabe pro Commit auf eine Zeile reduziert werden.

```bash
repo_1$ git log --pretty=oneline
221df61c6e0b69af839d95efff837ecebf7e443f (HEAD -> main) feat: Start des ersten Kapitels
```

Mit den Parametern `--oneline --decorate` wird die Ausgabe noch kürzer. Dabei wird der Commit-Hash auf 7 Zeichen gekürzt (statt 32). Die Kürzung ist für die meisten Repositories unproblematisch und weiterhin eindeutig.

```bash
repo_1$ git log --oneline --decorate
221df61 (HEAD -> main) feat: Start des ersten Kapitels
```

### Aliases

Da man die langen Befehle mit vielen Parametern nicht jedes Mal aus dem Gedächtnis herauskramen will, bietet git die Möglichkeit, diese mit einem Alias (alternativen Namen) zu versehen. Wir vergeben für unsere Log-Anzeige ein Alias `pl` (für pritty log).

```bash
repo_1$ git config --global alias.pl 'log --graph --oneline --decorate --all'
```

Das Alias wir dabei in der globalen (`--global`) Konfiguration von git gespeichert.

- `log`: git Befehl, in unserem Fall log
- `--graph`: Darstelluing des Logs als Graph (dazu später mehr, wenn wir mehr als ein branch haben)
- `--oneline`: Einzeilige Darstelluing
- `--decorate`: _Hübsche_ Darstellung der Zeile
- `--all`: Alle Branches anzeigen, nicht nur das aktuelle (später mehr dazu)

Nun können wir mit dem einfachen `git pl` das Log mit vielen Parametern einfach aufrufen.

```bash
repo_1$ git pl
* 221df61 (HEAD -> main) feat: Start des ersten Kapitels
```
