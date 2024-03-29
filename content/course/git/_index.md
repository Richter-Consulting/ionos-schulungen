---
title: "Workshop: Versionen dezentral verwalten mit Git"
linkTitle: Git Workshop
type: book
date: '2021-09-13'
tags:
- Git
- MVHS
weight: 10
summary: |
    Arbeiten Sie in einer Gruppe an einem Dokument oder programmieren Sie gerne? Wollen Sie wissen, was Sie oder Andere zuletzt am Dokument geändert haben?

    Lernen Sie, wie eine Version (von einem oder mehreren Dokumenten) mit Git auf dem Rechner gesichert, verglichen, mit anderen geteilt, zusammengeführt und wiederhergestellt werden kann. Erstellen Sie mehrere Bearbeitungszweige, um an mehreren Dokumentversionen parallel arbeiten zu können.

    Kursinhalt: Grundlagen Versionierung; Geschichte; aktuelle Systeme; Strategien; lokaler Einsatz von Git; Git mit Server-Einsatz; Arbeiten an mehreren Zweigen.
---

- {{< icon name="slideshare" pack="fab" >}} [Präsentation]({{< relref "/slides/git" >}})
- {{< icon name="file-pdf" pack="fas" >}} [Präsentation (Download)](git_slides.pdf)
- {{< icon name="calendar-day" pack="fas" >}} [Nächster Kurs]({{< relref "/event/git-2023-2" >}})

> _Die Code-Beispiele werden für Linus/macOS in Bash und unter Windows in PowerShell (Core) abgebildet. Sind die erforderlichen Befehle gleich, werden diese nur in Bash angezeigt. Die Anweisungen können 1:1 in PowerShell eingegeben werden._

## Installation von Git

Ob git auf Ihrem System installiert ist, können Sie mit dem folgenden Befehl in der Commandozeile / Terminal / Bash / PowerShell ausprobieren:

```bash
# Linux / macOS
kurse$ git --version
git version 2.33.0 
```

```powershell
# Windows
PS kurse> git --version
git version 2.33.0.windows.2
```

Wird statt einer Versionsangabe eine Fehlermeldung angezeigt, dass das `git` Befehl nicht gefunden wurde, muss git zuerst installiert werden.

> Der Befehl "git" ist entweder falsch geschrieben oder konnte nicht gefunden werden.

Folgen Sie dazu der Installationsanleitung für Ihr Betriebssystem von der offiziellen [git Seite](https://git-scm.com/).
