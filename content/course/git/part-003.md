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
# Linux / macOS
repo_1$ git log
commit 221df61c6e0b69af839d95efff837ecebf7e443f (HEAD -> master)
Author: Eugen [WebDucer] Richter <kurse@richter.consulting>
Date:   Tue Sep 21 08:06:48 2021 +0200

    feat: Start des ersten Kapitels
```

### Verkürzte Anzeige der Historie

Wenn die Anzahl der Commits steigt, wird die _ausführliche_ Ausgabe der Historie sehr unübersichtlich. Mit dem Parameter `--pretty=oneline` kann die Ausgabe pro Commit auf eine Zeile reduziert werden.

```bash
# Linux / macOS
repo_1$ git log --pretty=oneline
221df61c6e0b69af839d95efff837ecebf7e443f (HEAD -> master) feat: Start des ersten Kapitels
```

Mit den Parametern `--oneline --decorate` wird die Ausgabe noch kürzer. Dabei wird der Commit-Hash auf 7 Zeichen gekürzt (statt 32). Die Kürzung ist für die meisten Repositories unproblematisch und weiterhin eindeutig.

```bash
# Linux / macOS
repo_1$ git log --oneline --decorate
221df61 (HEAD -> master) feat: Start des ersten Kapitels
```