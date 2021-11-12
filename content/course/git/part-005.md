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