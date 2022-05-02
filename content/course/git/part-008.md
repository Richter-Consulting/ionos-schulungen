---
title: "Konflikte beim Zusammenführen lösen"
linkTitle: Konflikte
type: book
date: '2021-11-11'
tags:
- Git
- MVHS
weight: 90
---

Erstellen wir für einen Konflikt zuerst einen neuen Branch.

```bash
repo_1$ git checkout -b feat_kap_5
Switched to a new branch 'feat_kap_5'
```

Erstellen Sie nun eine neue Datei `kapitel_5.txt` mit dem folgenden Inhalt und fügen Sie diese Datei zur Versionsverwaltung.

```markdown
# Kapitel 5
Nach 8 stünddiger Fahrt ...
```

```bash
_repo_1> git commit -m "Fahrt im Zug"
[feat_kap_5 1b28574] Fahrt im Zug
 1 file changed, 2 insertions(+)
 create mode 100644 kapitel_5.txt
```

Jetzt ändern wir bereits vorhandene Dateien, um einige Konflikte zu provozieren. Ändern Sie die Datei `kapitel_1.txt` wie folgt (`+`-neuer Inhalt, `-`-gelöschter Inhalt).

```diff
Es war ein Mal...
- Nach 20 Jahren treffen sich die Freunde wieder.
+ Nach langen 19 Jahren trafen sich die Freunde wieder,
+ um neue Pläne zu schmieden.
Sie verabredeten sich in ihrem alten Kaffee zu treffen,
```

Ändern Sie noch die Datei `kapitel_4.txt` wie folgt.

```diff
Im vierten Jahr stand der Weizen ...

- Darauf folgte eine dreijährige Düre...
+ Nach 3 Jahren der sehr guten Ernten kam nun die Dürre,
+ die die nächsten 8 Jahre andauern sollte.
```

Das Log sollte in etwa wie unten aussehen.

```bash
repo_1$ git pl
* 408a803 (HEAD -> feat_kap_5) Kapitel 4 überarbeitet
* 47c1c6d Kapitel 1 überarbeitet
* 1b28574 Fahrt im Zug
*   e779542 (main) Merge branch 'develop'
|\
| * aac4d8b (develop) Nachtszene
| * e6b896a Ideen zum zweiten Kapitel
* | 10eabc1 Die Düre-Jahre
* | 054db53 Vierter Kapitel über...
* | 663ea5a Versenkung
* | 63bb3f0 Kapitel 3 plot
|/
* 027c2f3 Korrekturen am Kapitel 1
* e4c2672 Treffen nach 20 Jahren
* bd4b2df Fortsetzung in vielen Jahren
* e47bbe0 Kapitel 1 der Geschichte starten
* c3b4e8b Add repo ignore file for temp files
* e12fb6d feat: Start des ersten Kapitels
```

Wechseln wir nun auf den `main` Branch und machen mit den Änderungen weiter.

```bash
repo_1$ git checkout main
Switched to branch 'main'
```

Auch hier ändern wird die beiden Dateien `kapitel_1.txt` und `kapitel_4.txt` an denselben Zeilen. Zusätzlich legen wir auch einen neuen Kapitel 6 an.

```diff
- Nach 20 Jahren treffen sich die Freunde wieder.
+ Nach nicht ganz 20 Jahren treffen sich die Freunde wieder.
```

```diff
- Darauf folgte eine dreijährige Düre...
+ Darauf folgte eine achtjährige Dürre...
```

Vor dem Zusammenführena sollte das Log nun wie folgt aussehen.

```bash
repo_1$ git pl
* 618450e (HEAD -> main) Kapitel 6 gestartet
* 54a8d9a Kapitel 2 überarbeitet
* 0b1ad44 Kapitel 1 ausgearbeitet
| * 408a803 (feat_kap_5) Kapitel 4 überarbeitet
| * 47c1c6d Kapitel 1 überarbeitet
| * 1b28574 Fahrt im Zug
|/
*   e779542 Merge branch 'develop'
|\
| * aac4d8b (develop) Nachtszene
| * e6b896a Ideen zum zweiten Kapitel
* | 10eabc1 Die Düre-Jahre
* | 054db53 Vierter Kapitel über...
* | 663ea5a Versenkung
* | 63bb3f0 Kapitel 3 plot
|/
* 027c2f3 Korrekturen am Kapitel 1
* e4c2672 Treffen nach 20 Jahren
* bd4b2df Fortsetzung in vielen Jahren
* e47bbe0 Kapitel 1 der Geschichte starten
* c3b4e8b Add repo ignore file for temp files
* e12fb6d feat: Start des ersten Kapitels
```

Versuchen Sie nun die Zusammenführung. Diese sollte nun scheitern, da git nicht in der Lage ist, die Konflikte zu lösen. Die Änderungen sind auf beiden Branches in denselben Zeilen. Wir müssen die Konflikte manuell lösen.

```bash
repo_1$ git merge feat_kap_5
Auto-merging kapitel_1.txt
CONFLICT (content): Merge conflict in kapitel_1.txt
Auto-merging kapitel_4.txt
CONFLICT (content): Merge conflict in kapitel_4.txt
Automatic merge failed; fix conflicts and then commit the result.
```

### Übernahme einer der Versionen

Der `main` Brnach befindet sich wegen dem Konflikt nun in einem "Merge" Status. Mit `git status` können wir immer den aktuellen Stand bei Konfliktlösung sehen.

```bash
repo_1$ git status
On branch main
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Changes to be committed:
        new file:   kapitel_5.txt

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   kapitel_1.txt
        both modified:   kapitel_4.txt
```

Bei dem Konflikt im Kapitel 1 möchten wir einfach die Änderungen aus dem Branch `feat_kap_4` übernehmen. Dazu nutzen wir den `checkout` Befehl mit dem `--theirs` oder `--ours` Parameter und dem Dateinamen.

- `--theirs`: Es wird die Version aus dem **anderen** Branch genommen. Da wir auf `main` sind, ist es die Version aus Branch `feat_kap_5`.
- `--ours`: Es wird unsere Version genommen, also aus dem `main` Branch.

Nach dem Auschecken der gewollten Version muss die Lösung des Konfliktes mit `git add`, beendet werden.

```bash
repo_1$ git checkout --theirs -- kapitel_1.txt
repo_1$ git add kapitel_1.txt
repo_1$ git status
On branch main
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Changes to be committed:
        modified:   kapitel_1.txt
        new file:   kapitel_5.txt

Unmerged paths:
  (use "git add <file>..." to mark resolution)
        both modified:   kapitel_4.txt
```

### Manuelle Korrekturen

Nun haben wir noch ein Konflikt, in der Datei `kapitel_4.txt`. Diesen Konflikt möchten wir manuell lösen, da wir Änderungen aus beiden Branches kombinieren möchten. Aktuell sieht die Datei wie folgt aus:

```markdown
# Kapitel 4
Im vierten Jahr stand der Weizen ...

<<<<<<< HEAD
Darauf folgte eine achtjährige Düre...
=======
Nach 3 Jahren der sehr guten Ernten, kam nun die Dürre,
die die nächsten 8 Jahre andauern sollte.
>>>>>>> feat_kap_5

```

- `<<<<<<< HEAD`: Markierung für den Start des Bereiches mit den Änderungen aus dem aktuellen Branch.
- `=======`: Markierung zur Trennung zwischen den Änderungen aus den beiden Brnaches.
- `>>>>>>> feat_kap_5`: Markierung zum Ende der Änderungen aus dem _anderen_ Branch.

Die Datei können wir nun manuell bearbeiten und in den Zustand bringen, den wir haben möchten. Die _Markierungen_ sollen am Ende alle entfernt werden.

```markdown
# Kapitel 4
Im vierten Jahr stand der Weizen ...

Darauf folgte eine achtjährige Dürre...
Die die nächsten 8 Jahre andauern sollte.

```

Auch die Lösung von diesem Konflikt muss mit `git add` beendet werden. Der gesammte Merge wird dann über ein `git commit` abgeschlossen.

```bash
repo_1$ git add kapitel_4.txt
repo_1$ git status
On branch main
All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:
        modified:   kapitel_1.txt
        modified:   kapitel_4.txt
        new file:   kapitel_5.txt
repo_1$ git commit -m "Merge branch 'feat_kap_5'"
[main 7a000b4] Merge branch 'feat_kap_5'
```

Die Historie sollte nun unsere erfolgreiche Zusammenführung anzeigen.

```bash
repo_1$ git pl
*   7a000b4 (HEAD -> main) Merge branch 'feat_kap_5'
|\
| * 408a803 (feat_kap_5) Kapitel 4 überarbeitet
| * 47c1c6d Kapitel 1 überarbeitet
| * 1b28574 Fahrt im Zug
* | 618450e Kapitel 6 gestartet
* | 54a8d9a Kapitel 2 überarbeitet
* | 0b1ad44 Kapitel 1 ausgearbeitet
|/
*   e779542 Merge branch 'develop'
|\
| * aac4d8b (develop) Nachtszene
| * e6b896a Ideen zum zweiten Kapitel
* | 10eabc1 Die Düre-Jahre
* | 054db53 Vierter Kapitel über...
* | 663ea5a Versenkung
* | 63bb3f0 Kapitel 3 plot
|/
* 027c2f3 Korrekturen am Kapitel 1
* e4c2672 Treffen nach 20 Jahren
* bd4b2df Fortsetzung in vielen Jahren
* e47bbe0 Kapitel 1 der Geschichte starten
* c3b4e8b Add repo ignore file for temp files
* e12fb6d feat: Start des ersten Kapitels
```