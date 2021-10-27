---
title: "Eine Datei versionieren"
linkTitle: Datei versionieren
type: book
date: '2021-09-13'
tags:
- Git
- MVHS
weight: 30
---

Legen wir eine neue Text-Datei an, die wir versionieren möchten.

```bash
# Linux / macOS
repo_1$ touch kapitel_1.txt
```

```powershell
# Windows
PS repo_1> New-Item kapitel_1.txt

    Directory: C:\Users\kurs\src\repo_1

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          21.09.2021    07:32              0 kapitel_1.txt
```

Wenn wir nun den Status des Repositorys aufrufen, erhalten wir eine ganz andere Meldung.

```bach
PS repo_1>git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        kapitel_1.txt

nothing added to commit but untracked files present (use "git add" to track)
```

### Datei zum Staging-Bereich hinzufügen

Die Meldung besagt, dass in unserem Ordner eine neue, noch nicht versionierte (_untracked_) Datei liegt. Git gibt zugleich auch den Tipp, wie diese Datei unter Versionskontrolle genommen werden kann. Wir folgen einfach dem Tipp. Mit `status` prüfen wir wieder, welche Auswirkung das auf unser Repository hat.

```bash
repo_1$ git add kapitel_1.txt
repo_1$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   kapitel_1.txt
```

Nun besagt die Meldung, dass wir Änderungen haben, die auf ein Commit warten.

### Änderungen festschreiben

{{< callout note >}}
**Commit** bei git ist eine Aktion, mit der der aktuelle Stand als Version gespeichert wird. Zu einem Commit müssen die betroffenen Dateien vorgemerkt werden. Dieses Vormerken wird auch **Staging** genannt.
{{< /callout >}}

Nun schreiben wir die Version mit einen `commit` endgültig fest. Dabei ist es bei git auch immer notwendig eine Nachricht mitzugeben (Parameter `-m`), die die aktuelle Version beschreibt. Eine gute Dokumentation, wie eine Commit-Nachricht aussehen könnte, finden Sie unter [Konventionelle Commits](https://www.conventionalcommits.org/de/v1.0.0/).

Wird die Nachricht (Message) nicht direkt mit angegeben, startet git automatisch vorkonfigurierten Text-Editor, um die Nachricht in diesem einzugeben. Das ist sehr praktisch, wenn man mehrzeilige Nachrichten an die Version anhängen möchte.

```bash
repo_1$ git commit -m "feat: Start des ersten Kapitels"

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: empty ident name (for <kurse@pc.localdomain>) not allowed
```

### Benutzer in git einrichten

{{< callout warning >}}
Nutzten Sie git zum ersten Mal, erscheint eine Fehlermeldung, dass git uns noch nicht kennt. Git benötigt immer den Namen und die E-Mail-Adresse des Benutzers, um diese in der Versionshistorie zu nutzen. In der Fehlermeldung steh auch, wie der Fehler korrigiert werden kann.
{{< /callout >}}

```bash
repo_1$ git config --global user.email "kurse@richter.consulting"
repo_1$ git config --global user.name "Eugen [WebDucer] Richter"
repo_1$ git commit -m "feat: Start des ersten Kapitels"
[master (root-commit) 221df61] feat: Start des ersten Kapitels
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 kapitel_1.txt
```

Jetzt haben wir unseren ersten Commit mit git erstellt. Mit `git status` kann nachgeprüft werden, ob das Repository nun wieder in einen _sauberen_ Zustand ist.

### Allgemeiner Ablauf

Der allgemeine Ablauf beim Arbeiten mit git sieht damit wie folgt aus:

1. Anlegen oder ändern der Dateien, die versioniert werden sollen.
2. Hinzufügen der neuen oder geänderten Dateien über `git add dateiA dateiB`.
3. Festschreiben der neuen Version mit `git commit -m "Was und warum wurde etwas geändert"`.