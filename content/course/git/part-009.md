---
title: "Benannte Versionen mit Tags"
linkTitle: Tags
type: book
date: '2021-11-11'
tags:
- Git
- MVHS
weight: 100
---

Wir Menschen sind nicht dazu geeignet Hash-Werte zu merken. Das ist aber manchmal notwendig, um zu einem bestimmten Stand in der Geschichte zurückkehren zu können. Hier helfen und sogenannte `Tags`, die an ein Commit angehängt werden können. Wir können diese als eine kleine Notiz an einem Commit vorstellen.

Git unterstützt dabei zwei Arten von Tags.

- Leichtgewichtige Tags, die nur aus dem Tag selbst bestehen. Es ist am Ende ein einfacher Zeiger auf den Commit, wie bei Branches, der sich aber nicht bewegt.
- Annotierte Tags, die neben dem Tag selbst noch weitere Informationen tragen, wie eine zusätzliche Nachricht.

## Leichtgewichtiger Tag

Legen wir zuerst einen leichtgewichtigen Tag an, der auf den _letzten_ Commit zeigt. Dazu nutzen wir das `git tag` Befehl mit dem Namen des Tags.

```bash
repo_1$ git tag 'kap-05'
repo_1$ git pl
*   7a000b4 (HEAD -> main, tag: kap-05) Merge branch 'feat_kap_5'
|\
| * 408a803 (feat_kap_5) Kapitel 4 überarbeitet
...
repo_1$ git tag
kap-05
```

Mit `git tag` können wir alle Tags der Repositories auflisten lassen. Mit `git show` können wir die Informationen zu einem Commit, oder Tag aufrufen. Bei leichtgewichtigen erscheinen dabei keine zusätzlichen Informationen.

```bash
repo_1$ git show kap-05
commit 7a000b46cdd307aea91cc0e151fa6b7ff7daad78 (HEAD -> main, tag: kap-05)
Merge: 618450e 408a803
Author: Eugen [WebDucer] Richter <github@webducer.de>
Date:   Mon May 2 06:56:58 2022 +0200

    Merge branch 'feat_kap_5'

diff --cc kapitel_4.txt
...
```

## Annotierter Tag

Nun legen wir einen annotierten Tag an, der neben der Nachricht, auch auf einen bestimmten Commit angehängt wird, nicht den aktuellen. Dazu wird der Parameter `-a` (für annotiert) und `-m` (für Message) genutzt. Der Commit auf den wir uns beziehen, wird als Hash (oder `HEAD`-Relative-Referenz, wie bei `diff`) mit angegeben.

```bash
repo_1$ git tag -a 'kap-04' e779542 -m "Kapitel 4 über Tag"
repo_1$ git pl
*   7a000b4 (HEAD -> main, tag: kap-05) Merge branch 'feat_kap_5'
|\
| * 408a803 (feat_kap_5) Kapitel 4 überarbeitet
| * 47c1c6d Kapitel 1 überarbeitet
| * 1b28574 Fahrt im Zug
* | 618450e Kapitel 6 gestartet
* | 54a8d9a Kapitel 2 überarbeitet
* | 0b1ad44 Kapitel 1 ausgearbeitet
|/
*   e779542 (tag: kap-04) Merge branch 'develop'
...
_repo_1$ git show kap-04
tag kap-04
Tagger: Eugen [WebDucer] Richter <github@webducer.de>
Date:   Mon May 2 07:13:57 2022 +0200

Kapitel 4 über Tag

commit e7795427bf9235f54e8fc3cc73b0fa4f43678373 (tag: kap-04)
Merge: 10eabc1 aac4d8b
Author: Eugen [WebDucer] Richter <github@webducer.de>
Date:   Mon May 2 05:46:44 2022 +0200
...
```

Bei `git show` sehen wir nun neben den Informationen zu dem Commit selbst (fängt mit `commit e7794` an) auch die Informationen zu dem Tag (es können auch mehrere sein) oberhalb von diesem. Hier werden neben der Nachricht auch die Informationen zu dem Ersteller des Tags angezeigt.