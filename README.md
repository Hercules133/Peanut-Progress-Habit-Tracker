# Peanut Progress 

A Habit Tracker

# Projektstruktur

```plaintext
lib/
├── main.dart                 # Einstiegspunkt der Anwendung
├── core/                     # Wiederverwendbarer, zentraler Code für das gesamte Projekt
│   ├── config/               # Konfigurationsdateien (z.B. Umgebungsvariablen, Dependency Injection)
│   ├── utils/                # Hilfsfunktionen und Utility-Klassen
│   └── widgets/              # Wiederverwendbare Widgets (z.B. Buttons, Eingabefelder)
├── data/                     # Datenverwaltungsschicht
│   ├── models/               # Datenmodelle
│   ├── providers/            # Zustandsverwaltung und Datenquellen
│   └── repositories/         # Abstraktionsebene über Datenquellen
├── features/                 # Modularisierte Features der App
│   ├── feature1/             # Beispiel-Feature 1
│   │   ├── view/             # UI für das Feature (screen und Widgets)
│   │   ├── model/            # Datenmodelle spezifisch für dieses Feature
│   │   ├── controller/       # Zustandsverwaltung für dieses Feature
│   │   └── repository/       # Datenzugriffsschicht spezifisch für dieses Feature
│   └── feature2/             # Beispiel-Feature 2 (zusätzliches Feature)
├── services/                 # Externe Services (z.B. API-Clients, Datenbanken)
├── resources/                # Ressourcen der App (z.B. Lokalisierung, Styles)
```

---

## Ordnerdetails

### `core/`
Dieser Ordner enthält zentralen Code, der überall in der App verwendet wird.  
- **`config/`**: Konfigurationen wie Dependency Injection, Umgebungsvariablen, etc.  
- **`utils/`**: Allgemeine Hilfsfunktionen und Tools.  
- **`widgets/`**: Wiederverwendbare UI-Komponenten, die in verschiedenen Features benutzt werden.

### `data/`
Dieser Ordner enthält globale Modelle, Provider und Repositories, die in mehreren Features verwendet werden. Es handelt sich um zentrale Module, die eine wiederverwendbare und standardisierte Schnittstelle für verschiedene Teile der App bieten. 

- **`models/`**: Globale Datenmodelle, die in mehreren Features verwendet werden können.  
- **`providers/`**: Globale Provider für die Zustandsverwaltung, die featureübergreifend genutzt werden können.  
- **`repositories/`**: Repositories als Abstraktionsschicht für Datenquellen, die von verschiedenen Features verwendet werden.

### `features/`
Jedes Feature der App hat einen eigenen Ordner, um alle dazugehörigen Dateien zu kapseln.  
- **`feature1/`**: Beispiel-Feature mit folgenden Unterordnern:  
  - **`view/`**: UI-Komponenten wie screen und Widgets.  
  - **`model/`**: Datenmodelle speziell für dieses Feature.  
  - **`controller/`**: Zustandsmanagement oder Logik des Features.  
  - **`repository/`**: Datenlogik und Abstraktion spezifisch für dieses Feature.

### `services/`
Externe Services wie API-Clients, Datenbanken oder Speichermechanismen.  
- Beispiel: Authentifizierung oder lokale Speicherung.

### `resources/`
Ressourcen, die für die gesamte App verfügbar sind, wie z.B.:  
- Lokalisierungsdateien (`.arb`/`.json`), Theme-Dateien.
