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
    ```
    # Kapitel 1
    Es war ein Mal...
    ```
  - Message: `Kapitel 1 der Geschichte starten`
- Commit 2
  - Inhalt
    ```
    Viele Jahre später ...
    ```
  - Message: `Vortsetzung in vielen Jahren`
- Commit 3
  - Inhalt
    ```
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
# Linux / macOS
repo_1$ git pl
* 184a87e (HEAD -> master) Treffen nach 20 Jahren
* de63512 Vortsetzung in vielen Jahren
* c58434b Kapitel 1 der Geschichte starten
* d8f7b79 Add repo ignore file for temp files
* 221df61 feat: Start des ersten Kapitels
```

## Aktuelle Änderungen zeigen

Ruft man den Befehl `git diff <Dateiname>` ohne weitere Parameter auf, zeigt dieses die aktuellen Änderungen an, also was sich seit dem letzen Commit in der Datei geändert hat. Rufen Sie es mit einer Datei, die keine Änderungen hat, gibt der Befehl nichts aus.

Ohne einen Dateinamen, werden die Änderungen vom kompletten Repository angezeigt. Die Anzeige erfolgt dabei im **DIFF** Format. Die neuen zeilen werden über ein `+` vor der Zeile angezeigt, entferne mit einem `-`.

Ändern Sie nun unsere Datei `kapitel_1.txt` wie folgt, ohne die Änderungen in die Versionsverwaltung festzuschreiben:

1. Entfernen Sie die Zeile 3 (`Viele Jahre später ...`)
2. Fügen Sie nach der Zeile 3 folgendes ein
    ```
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

```bash
# Linux / macOS
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

Wir senen hier in DIFF Format, dass eine Zeile (nach "Es war ein Mal...") entfernt wurde, und zwei Zeilen (zwischen "Nach 20 Jahren treffen sich die Freunde wieder." und "Das Kaffee, dass damals an diesem Platz stand, existiert nicht mehr.") dazu gekommen sind.

Diese Anzeige zeigt den Unterschied zwischen dem letzen Commit und der aktuellen Arbeitsversion.

## Unterschiede zwischen zwei Commits

Wollen wir die Datei zwischen zwei bestimmten Versionen (Commits) vergleichen, müssen wird das `diff` Commando mit wenigen Parametern erweitern. Die sehr umfangreiche Liste der möglichen Parameter kann mit `git diff --help` aufgerufen werden. Uns interessiren aktuell nur die zwei gängigsten, bei dennen die zwei **Anker** mit angegeben werden. Ein Anker kann dabei ein Commit, ein Branch oder ein Tag sein.

Als erstes können wir explizit zwei Commit angeben, die wir miteinander vergleichen wollen. Die Commit-Hashes können wir sehr einfach mit unserem `git pl` Alias anzeigen lassen.

```bash
# Linux / macOS
repo_1$ git pl
* 184a87e (HEAD -> master) Treffen nach 20 Jahren
* de63512 Vortsetzung in vielen Jahren
* c58434b Kapitel 1 der Geschichte starten
* d8f7b79 Add repo ignore file for temp files
* 221df61 feat: Start des ersten Kapitels
repo_1$ git diff d8f7b79 de63512
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

Wenn Sie in der Historie nur wenige Commits zurück gehen wollen, lässt sich das auch mit dem `HEAD` Zeiger erledigen. `HEAD` steht immer auf dem letzen Commit. Mit der `^` und `~x` Syntax kann man vom `HEAD` aus 1 oder `x` Commits zurück gehen. Das obere Ergebnis erreichen wir also auch mit dem folgenden Befehl (ohne die Commit-Hashes zu kennen).

```bash
# Linux / macOS
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

Passen Sie auf die Reihenfolge auf. Im Normalfall interessiert Sie, was seit einem bestimmten Commit passiert ist, die Reihenfolge der Parameter ist also älterer Commit und dann neuerer. Wenn Sie die Parameter vertauchen, erhalten Sie die Ansicht, was müsste gemacht werden, um den _ursprünglichen_ Zustand wieder zu erhalten.

```bash
# Linux / macOS
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