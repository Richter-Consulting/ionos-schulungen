---
title: "Änderungen zwischen Version anzeigen"
linkTitle: Änderungen
type: book
date: '2021-11-11'
tags:
- Git
- MVHS
weight: 60
---
Wenn man mit der Zeit eine Versionshistorie aufgebaut hat, kommt der Zeitpunkt, wenn man zwei Versionen einer Datei miteinander vergleichen möchte. Dazu bietet git den Befehl `diff` an, der mit einigen Parametern gesteuert werden kann.

Legen wir zuerst ein paar Commits mit Änderungen an, damit etwas zum Anschauen haben. Aktuell ist unsere Datei `kapitel_1.txt` leer.

- Commit 1
  - Inhalt
    ```markdown
    # Kapitel 1
    Es war ein Mal...
    ```
  - Message: `Kapitel 1 der Geschichte starten`
- Commit 2
  - Inhalt
    ```markdown
    Viele Jahre später ...
    ```
  - Message: `Fortsetzung in vielen Jahren`
- Commit 3
  - Inhalt
    ```markdown
    Nach 20 Jahren treffen sich die Freunde wieder.
    Das Kaffee, dass damals an diesem Platz stand, existiert nicht mehr.
    ```
  - Message: `Treffen nach 20 Jahren`

Am Ende sollte der Inhalt der Datei wie folgt aussehen.

```markdown
# Kapitel 1
Es war ein Mal...
Viele Jahre später ...
Nach 20 Jahren treffen sich die Freunde wieder.
Das Kaffee, dass damals an diesem Platz stand, existiert nicht mehr.
```

Und die Historie mit unserem Alias `pl` sollte in etwa wie folgt aussehen (die Hashwerte sind bei Ihnen natürlich ganz anders).

```bash
repo_1$ git pl
* e4c2672 (HEAD -> main) Treffen nach 20 Jahren
* bd4b2df Fortsetzung in vielen Jahren
* e47bbe0 Kapitel 1 der Geschichte starten
* c3b4e8b Add repo ignore file for temp files
* e12fb6d feat: Start des ersten Kapitels
```

## Aktuelle Änderungen zeigen

Ruft man den Befehl `git diff <Dateiname>` ohne weitere Parameter auf, zeigt dieses die aktuellen Änderungen an, also was sich seit dem letzTen Commit in der Datei geändert hat. Rufen Sie es mit einer Datei, die keine Änderungen hat, gibt der Befehl nichts aus.

Ohne einen Dateinamen werden die Änderungen vom kompletten Repository angezeigt. Die Anzeige erfolgt dabei im **DIFF** Format. Die neuen Zeilen werden über ein `+` vor der Zeile angezeigt, entferne mit einem `-`.

Ändern Sie nun unsere Datei `kapitel_1.txt` wie folgt, ohne die Änderungen in die Versionsverwaltung festzuschreiben:

1. Entfernen Sie die Zeile 3 (`Viele Jahre später ...`)
2. Fügen Sie nach der Zeile 3 folgendes ein
    ```markdown
    Sie verabredeten sich in ihrem alten Kaffee zu treffen,
    dass sie immer nach der Schule besucht haben.
    ```

Der text sollte nun wie folgt aussehen:

```markdown
# Kapitel 1
Es war ein Mal...
Nach 20 Jahren treffen sich die Freunde wieder.
Sie verabredeten sich in ihrem alten Kaffee zu treffen,
dass sie immer nach der Schule besucht haben.
Das Kaffee, dass damals an diesem Platz stand, existiert nicht mehr.
```

Rufen Sie nun den Befehl `git diff` auf (mit oder ohne den Dateinamen).

```diff
repo_1$ git diff kapitel_1.txt
diff --git a/kapitel_1.txt b/kapitel_1.txt
index 20f47a6..8cc2eca 100644
--- a/kapitel_1.txt
+++ b/kapitel_1.txt
@@ -1,5 +1,6 @@
 # Kapitel 1
 Es war ein Mal...
-Viele Jahre später ...
 Nach 20 Jahren treffen sich die Freunde wieder.
+Sie verabredeten sich in ihrem alten Kaffee zu treffen,
+dass sie immer nach der Schule besucht haben.
 Das Kaffee, dass damals an diesem Platz stand, existiert nicht mehr.
\ No newline at end of file
```

Wir sehen hier in DIFF Format, dass eine Zeile (nach "Es war ein Mal...") entfernt wurde, und zwei Zeilen (zwischen "Nach 20 Jahren treffen sich die Freunde wieder." und "Das Kaffee, dass damals an diesem Platz stand, existiert nicht mehr.") dazu gekommen sind.

Diese Anzeige zeigt den Unterschied zwischen dem letzten Commit und der aktuellen Arbeitsversion.

## Unterschiede zwischen zwei Commits

Wollen wir die Datei zwischen zwei bestimmten Versionen (Commits) vergleichen, müssen wird das `diff` Commando mit wenigen Parametern erweitern. Die sehr umfangreiche Liste der möglichen Parameter kann mit `git diff --help` aufgerufen werden. Uns interessieren aktuell nur die zwei gängigsten, bei denen die zwei **Anker** mit angegeben werden. Ein Anker kann dabei ein Commit, ein Branch oder ein Tag sein.

Als Erstes können wir explizit zwei Commit angeben, die wir miteinander vergleichen wollen. Die Commit-Hashes können wir sehr einfach mit unserem `git pl` Alias anzeigen lassen.

```diff
repo_1$ git pl
* e4c2672 (HEAD -> main) Treffen nach 20 Jahren
* bd4b2df Fortsetzung in vielen Jahren
* e47bbe0 Kapitel 1 der Geschichte starten
* c3b4e8b Add repo ignore file for temp files
* e12fb6d feat: Start des ersten Kapitels
repo_1$ git diff c3b4e8b bd4b2df
diff --git a/kapitel_1.txt b/kapitel_1.txt
index e69de29..61a6fe5 100644
--- a/kapitel_1.txt
+++ b/kapitel_1.txt
@@ -0,0 +1,3 @@
+# Kapitel 1^M
+Es war ein Mal...^M
+Viele Jahre später ...
\ No newline at end of file
```

## `HEAD` Anker für `diff` nutzen

Wenn Sie in der Historie nur wenige Commits zurückgehen wollen, lässt sich das auch mit dem `HEAD` Zeiger erledigen. `HEAD` steht immer auf dem letzten Commit. Mit der `^` und `~x` Syntax kann man vom `HEAD` aus 1 oder `x` Commits zurückgehen. Das obere Ergebnis erreichen wir also auch mit dem folgenden Befehl (ohne die Commit-Hashes zu kennen).

```diff
repo_1$ git diff HEAD~3 HEAD^ kapitel_1.txt
diff --git a/kapitel_1.txt b/kapitel_1.txt
index e69de29..61a6fe5 100644
--- a/kapitel_1.txt
+++ b/kapitel_1.txt
@@ -0,0 +1,3 @@
+# Kapitel 1^M
+Es war ein Mal...^M
+Viele Jahre später ...
\ No newline at end of file
```

## Reihenfolge ist wichtig

Passen Sie auf die Reihenfolge auf. Im Normalfall interessiert Sie, was seit einem bestimmten Commit passiert ist, die Reihenfolge der Parameter ist also älterer Commit und dann neuerer. Wenn Sie die Parameter vertauschen, erhalten Sie die Ansicht, was müsste gemacht werden, um den _ursprünglichen_ Zustand wieder zu erhalten.

```diff
repo_1$ git diff HEAD^ HEAD~3 kapitel_1.txt
diff --git a/kapitel_1.txt b/kapitel_1.txt
index 61a6fe5..e69de29 100644
--- a/kapitel_1.txt
+++ b/kapitel_1.txt
@@ -1,3 +0,0 @@
-# Kapitel 1
-Es war ein Mal...
-Viele Jahre später ...
\ No newline at end of file
```

Schreiben Sie nun die letzte, noch nicht festgeschriebene Änderung an unserer Datei fest. Damit wir nicht jedes Mal zwei Befehle ausführen müssen (`add` + `commit`), können wir beides kombinieren. Dabei werden alle geänderten / gelöschten Dateien in das Stating-Bereich übernommen und in den Commit aufgenommen. Neue Dateien (die noch nicht unter Versionsverwaltung stehen) werden dabei nicht berücksichtigt. Diese müssen zuerst mit `git add` hinzugefügt werden.

```bash
/repo_1$ git commit -a -m "Korrekturen am Kapitel 1"
[main 027c2f3] Korrekturen am Kapitel 1
 1 file changed, 2 insertions(+), 1 deletion(-)
```

Der Parameter `-a` (oder auch in der Langschreibweise `--all`) führt zu der gewollten Aktion.