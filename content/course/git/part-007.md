---
title: "Änderungen eines Zweiges in ein Anderes übernehmen"
linkTitle: Zusammenführen
type: book
date: '2021-11-11'
tags:
- Git
- MVHS
weight: 80
---

Nach getaner Arbeit, sollen die unterschiedlichen Stände der Arbeit wieder zusammengeführt werden. Dabei kann es zu 3 Konstellationen kommen:

1. Fast-Merge: Es wurden nur Änderungen auf neuen Branch gemacht, aber nicht auf `main`. Damit kann git einfach den **Zeiger** für `main` Branch auf den neuen Stand setzen. In diesem Fall spricht man von "Fast Merge". Es wird dabei kein extra Commit erzeugt.
2. Merge: Beim Zusammenführen sind keine Probleme augetretten. In diesem Fall wir ein sogenannter "Merge"-Commit erstellt. Im Gegensatz zu einem normalen Commit, hat dieser Informationen zu den beiden Branches, statt nur einen.
3. Conflict: Beim Zusammenführen kommt es zu einem Konflikt, den git nicht selbst lösen kann. Wir müssen alle Konflikte beseitigen und das Zusammenführen abzuschließen.

Wir werden hier alle 3 Möglichkeiten durchspielen.

## Fast Merge

Wechseln Sie zuerst auf den `main`-Branch, wenn noch nicht geschehen. Erstellen Sie einen neuen Branch `feat_kap_4` und wechseln Sie zu diesem.

{{< callout note >}}
Da man meinstens beim Erzeugen eines neuen Branches auch gleich zu diesem wechseln möchte, gibt es eine Abkürzung. Statt `git branch <neuer_branch_name>` und `git checkout <neuer_branch_name>` eingeben zu müssen, kann man auch kürzer den `-b` Flag nutzen: `git checkout -b <neuer_branch_name>` eingeben.
{{</ callout >}}

```bash
repo_1$ git checkout main
Already on 'main'
repo_1$ git checkout -b feat_kap_4
Switched to a new branch 'feat_kap_4'
```

Nun legen wir eine neue Datei an, mit Inhalt, den wir auch mehrere Commits verteilen.

```markdown
# Kapitel 4
Im vierten Jahr stand der Weizen ...

Darauf folgte eine dreijährige Düre...
```

Am Ende sollte die Historie wie folgt aussehen:

```bash
repo_1$ git pl
* 10eabc1 (HEAD -> feat_kap_4) Die Düre-Jahre
* 054db53 Vierter Kapitel über...
* 663ea5a (main) Versenkung
* 63bb3f0 Kapitel 3 plot
| * aac4d8b (develop) Nachtszene
| * e6b896a Ideen zum zweiten Kapitel
|/
* 027c2f3 Korrekturen am Kapitel 1
* e4c2672 Treffen nach 20 Jahren
* bd4b2df Fortsetzung in vielen Jahren
* e47bbe0 Kapitel 1 der Geschichte starten
* c3b4e8b Add repo ignore file for temp files
* e12fb6d feat: Start des ersten Kapitels
```

Wenn man den Pfad folgt, sieht man hier sehr gut, dass `main` eigentlich auf demselben Pfad liegt, wie unser neuer neuer Branch `feat_kap_4`. Das ist die Voraussetzung für einen "Fast-Merge".

Wechselb wir nun zurück zu `main`. Anschließen führen wir die Beiden Zweige zusammen. Dazu muss man immer auf dem Branch drauf sein, in dem man den anderen Zweit integrieren will. Die Integration wird mit `git merge <branch_name>` durchgeführt. In der Ausgabe sollte nun sichtbar sein, dass ein "Fast-Merge" durchgeführt wurde.

```bash
repo_1$ git checkout main
Switched to branch 'main'
repo_1$ git merge feat_kap_4
Updating 663ea5a..10eabc1
Fast-forward
 kapitel_4.txt | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 kapitel_4.txt
```

Auch an dem Log ist es sichtbar, dass ein "Fast-Merge" erstellt wurde:

1. Es sind genauso viele Commits da, wie vorher.
2. Letzer Commit hat denselben Hash. D.h. dieser wurde nicht geändert.
3. Beide Branches, `main` und `feat_kap_4` zeichen auf denselben Commit.

```bash
repo_1$ git pl
* 10eabc1 (HEAD -> main, feat_kap_4) Die Düre-Jahre
* 054db53 Vierter Kapitel über...
* 663ea5a Versenkung
* 63bb3f0 Kapitel 3 plot
| * aac4d8b (develop) Nachtszene
| * e6b896a Ideen zum zweiten Kapitel
|/
* 027c2f3 Korrekturen am Kapitel 1
* e4c2672 Treffen nach 20 Jahren
* bd4b2df Fortsetzung in vielen Jahren
* e47bbe0 Kapitel 1 der Geschichte starten
* c3b4e8b Add repo ignore file for temp files
* e12fb6d feat: Start des ersten Kapitels
```

Da die Zusammenführung erfolgreich war, können wir den nicht mehr benötigten Branch `feat_kap_4` mit `git branch -d <branch_name>` löschen.

```bash
repo_1$ git branch -d feat_kap_4
Deleted branch feat_kap_4 (was 10eabc1).
```

## Merge

Für einen "normale" Zusammenführung haben wir auch bereits alles vorbereitet. Wir haben zwei Branches, auf dennen parallel gearbeitet wurde, `main` und `develop`. Nun können wir wieder auf `main` wechsel, falls noch nicht der Fall ist, und `develop` integrieren.

```bash
repo_1$ git checkout main
Already on 'main'
repo_1$ git merge develop
Merge made by the 'ort' strategy.
 kapitel_2.txt | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 kapitel_2.txt
repo_1$ git pl
*   e779542 (HEAD -> main) Merge branch 'develop'
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

An dem Log können wir sehr gut sehen, dass es dieses Mal ein neuer Commit (`e779542`) erzeugt wurde, der mit zwei anderen Commits (`aac4d8b` und `10eabc1`) verbunden ist.
