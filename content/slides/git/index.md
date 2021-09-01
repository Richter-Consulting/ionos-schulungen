---
title: VCS Git
authors:
- Eugen
tags:
- Git
- Versionsverwaltung
- VCS
categories: []
date: "2021-08-28"
slides:
  # Choose a theme from https://github.com/hakimel/reveal.js#theming
  theme: black
  # Choose a code highlighting style (if highlighting enabled in `params.toml`)
  #   Light style: github. Dark style: dracula (default).
  highlight_style: dracula
---

# Versionen dezentral verwalten mit Git

> Dipl.-Ing. (FH) Eugen Richter

---

## Git: Themen

- Warum Versionierung? 
- Geschichte der Versionsverwaltung (allgemein) 
- Geschichte von Git (im besonderen) 
- Übersicht über Versionierungsstrategien 
- Git auf der Console (Kommandozeile) 
- Git mit SourceTree (als Beispiel für eine graphische Oberfläche)

---

## Warum Versionierung?

- Datensicherung
- {{< fragment >}}Älterer Zustand{{< /fragment >}}
- {{< fragment >}}Parallele-Arbeit an mehreren Versionen{{< /fragment >}}
- {{< fragment >}}Parallele-Arbeit mit mehreren Personen{{< /fragment >}}

{{< speaker_note >}}
1. Sicherung der Daten (aktueller Stand)
2. Zurückkehren zum älteren Zustand (jederzeit)
3. Weiterentwicklung / Schreiben, während eine Version stabilisiert / korrigiert wird
4. Arbeiten mit mehreren Personen parallel an einen Projekt
{{< /speaker_note >}}

---

## Geschichte der Versionierung

- Zeitstempel-Ordner
- {{< fragment >}}Dateiversionierung {{< /fragment >}}
- {{< fragment >}}Zentral{{< /fragment >}}
- {{< fragment >}}Verteilt{{< /fragment >}}

{{< speaker_note >}}
- Timestamp
- Versionierung von einzelnen Dateien
	- Word / Excel
- Zentrale Versionsverwaltung
	- SVN
	- TFS
	- CVS
	- MS SourceSafe
- Vertiele Versionsverwaltung
	- Git
	- Mercurial
	- Bitkeeper
{{< /speaker_note >}}

---

## Geschichte von git

- 2005 von Linus Torwalds initialisiert 
- Erste Version in wenigen Tagen 
- Zur Verwaltung von Linux Kernel (sehr verteilte Entwicklung) 
- Sehr hohe Effizienz 
- Sehr hohe Sicherheit 
- Wegwerf-Zweige

{{< speaker_note >}}
- Nach dem Lizenzänderung von BitKeeper (keine kostenlose Lizenzen für OpenSource Projekte)
- Entwickelt von Linus Torwalds
- In April 2005 gestartet
- In wenigen Tagen erste Version veröffentlicht
- Ausgelegt auf
	- Effizienz
	- Sicherheit
	- Verteilt
	- Wegwerf-Zweige
- Git = Blödman
{{< /speaker_note >}}

---

## Versionsstrategien
### Lineare Entwicklung

![Linear git history](git_linear.png)

---

## Ein Branch - Pro

- Sehr einfache Benutzung
- Kein Merge zwischen unterschiedlichen Zweigen notwendig
- Sehr gut für den Einstieg in die Versionsverwaltung geeignet
- Sehr gut für Dokument-Versionierung (Bücher, Artikel,	Manuskripte usw.)

---

## Ein Branch - Contra

- Schwer zu handhaben, wenn mehr als nur ein Entwickler beteilig ist, da während des Release-Tests keine Weiterentwicklung für nächste Version möglich ist.
- Hotfixes einer Version sind sehr schwer zu realisieren, da eventuell bereits unvollständige Features für neue Version da sind.