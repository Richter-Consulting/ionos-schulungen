---
title: "Änderungen eines Zweiges in ein Anderes übernehmen"
linkTitle: Zusammenführen
type: book
date: '2021-11-11'
tags:
- Git
- MVHS
weight: 80
draft: true
---

Nach getaner Arbeit, sollen die unterschiedlichen Stände der Arbeit wieder zusammengeführt werden. Dabei kann es zu 3 Konstellationen kommen:

1. Fast-Merge: Es wurden nur Änderungen auf neuen Branch gemacht, aber nicht auf `main`. Damit kann git einfach den **Zeiger** für `main* Branch auf den neuen Stand setzen. In diesem Fall spricht man von "Fast Merge". Es wird dabei kein extra Commit erzeugt.
2. Merge: Beim Zusammenführen sind keine Probleme augetretten. In diesem Fall wir ein sogenannter "Merge"-Commit erstellt. Im Gegensatz zu einem normalen Commit, hat dieser Informationen zu den beiden Branches, statt nur einen.
3. Conflict: Beim Zusammenführen kommt es zu einem Konflikt, den git nicht selbst lösen kann. Wir müssen alle Konflikte beseitigen und das Zusammenführen abzuschließen.

Wir werden hier alle 3 Möglichkeiten durchspielen.

## Fast Merge

## Merge

## Conflict

### Übernahme einer der Versionen

### Manuelle Korrekturen