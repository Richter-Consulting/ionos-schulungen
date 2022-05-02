---
title: "Verzweigungen (Branches) anlegen"
linkTitle: Verzweigungen
type: book
date: '2021-11-12'
tags:
- Git
- MVHS
weight: 70
---
Früher oder später braucht man mehr als nur eine lineare Entwicklung auf einen einzigen Zweig. Der einfachste Ansatz dazu, ist mit `main` und `develop` Zweigen zu arbeiten. Dabei erfolgt auf dem `develop` Zweig die eigentliche Entwicklung. Auf dem `main` Zweig landen dann die **auslieferungsfähige** Versionen, die oft auch benannt werden (Tags - siehe übernächstes Kapitel).

## Branches anzeigen

Verschafen wir uns zuerst die Übersicht über die aktuell im Repository vorhandenen Zweige (Branches).

```bash
repo_1$ git branch
* main
```

Wir haben aktuell also nur den Branch `main`. Mit dem `*` wird bei mehreren Branches immer das aktuell aktive markiert.

{{< callout note >}}
Eventuell sehen Sie statt `main` einen `master` als Brnachnamen. Das hängt davon ab, wann Sie git auf Ihrem System installiert haben. Falls Sie eine ältere Installation haben, können Sie die globale Konfiguration mit folgender Zeile umstellen:

```bash
git config --global init.defaultBranch main
```

Den vorhandenen `master` Brnach können Sie auch jederzeit auf neue Konvention umstellen.

```bash
git branch -m master main
```
{{</ callout >}}

## Branches anlegen

Nun legen wir einen neuen Brnach an, den wir `develop` nennen. Dazu wird der Befehl `branch <neuer_name>` genutzt.

```bash
repo_1$ git branch develop
repo_1$ git branch
  develop
* main
```

## Zum Branch wechseln

Um nun auf den neuen Branch arbeiten zu können, wecheln wir zu diesem mit dem `checkout` Befehl.

```bash
repo_1$ git checkout develop
Switched to branch 'develop'
repo_1$ git branch
* develop
  main
```

Nun können wir auf diesem Zweig unsere Änderungen durchführen und festschreiben. Führen Sie für den nächsten Schritt nun folgende Schritte durch:

1. Legen Sie eine neue die Datei `kapitel_2.txt` an
2. Versionieren Sie diese
3. Fügen Sie folgenden Text zu der Datei:
    ```markdown
    # Kapitel 2
    Nach einer durchzechten Nacht ...
    ```
4. Schreiben Sie die Änderung in der Historie fest
5. Legen Sie eine neue Datei `kapitel_3.txt` an, ohne diese unter Versionsverwaltung zu stellen.

Am Ende sollte die Historie (und Status) in etwa wie folgt aussehen:

```bash
repo_1$ git pl
* aac4d8b (HEAD -> develop) Nachtszene
* e6b896a Ideen zum zweiten Kapitel
* 027c2f3 (main) Korrekturen am Kapitel 1
* e4c2672 Treffen nach 20 Jahren
* bd4b2df Fortsetzung in vielen Jahren
* e47bbe0 Kapitel 1 der Geschichte starten
* c3b4e8b Add repo ignore file for temp files
* e12fb6d feat: Start des ersten Kapitels
repo_1$ git status
On branch develop
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        kapitel_3.txt

nothing added to commit but untracked files present (use "git add" to track)
```

## Branch Verhalten

Jetzt haben wir zwei neue Dateien im Branch `develop` erstellt. Dabei haben wir eine davon unter die Versionsverwaltung (`kapitel_2.txt`). In dem Ordner liegen aktuell drei Dateien (+2 aus der Ausnahmeliste).

```bash
repo_1$ ls
kapitel_1.bak  kapitel_1.txt  kapitel_1.~  kapitel_2.txt  kapitel_3.txt
```

**_Was passiert nun, wenn wir zurück zu `main` wechseln? Wie wird der Ordner danach aussehen? Versuchen Sie es aus._**

```bash
repo_1$ git checkout main
Switched to branch 'main'
repo_1$ ls
kapitel_1.bak  kapitel_1.txt  kapitel_1.~  kapitel_3.txt
```

Sie haben wahrscheinlich erwartet, dass sowohl `kapitel_2.txt` als auch `kapitel_3.txt` nicht mehr da sind, da diese ja nicht in `main` erstellt wurden. Tatsächlich ist nur die Datei `kapitel_2.txt` nicht mehr da.

Das ist sehr einfach zu erklären. Git kümmert sich nur um Dateien, die unter seiner Kontrolle stehen (versioniert sind). Alle anderen Dateien werden einfach ignoriert. Genau das passiert mit `kapitel_3.txt`. Diese Datei steht noch nicht unter Versionskontrolle, weshalb diese von git unangetastet bleibt. Bei `kapitel_2.txt` ist der Fall anders. Diese steht unter Versionskontrolle. Damit weiß git, dass diese zwar im Zweig `develop` vorhanden ist, aber nicht in `main`. Aus diesem grund wird diese beim Wechsel gelöscht (oder angelegt beim Wechsel zurück).

{{< callout note >}}
Nicht versionierte Dateien sind für git unsichtbar und werden von diesem nicht angefasst.
{{</ callout >}}

## Paralles Arbeiten

Nun simulieren wir, dass auf beiden Branches nun gearbeitet wurde. Dazu versionieren wir die Datei `kapitel_3.txt` und fügen ein wenig Text hinzu.

```markdown
# Kapitel 3
Nach zwei Monaten in der Versenkung ...
```

Das wird unsere Basis für den nächsten Kapitel, in dem wir versuchen die Branches zusammenzuführen. Am Ende sollte die Versionshistorie in etwa wie folgt aussehen:

```bash
repo_1$ git pl
* 663ea5a (HEAD -> main) Versenkung
* 63bb3f0 Kapitel 3 Plot
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