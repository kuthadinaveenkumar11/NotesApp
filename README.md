# NoteApp

A simple iOS Note-Taking application built with SwiftUI, Core Data, and RESTful API integration. It supports offline note creation, editing, and deletion with sync capabilities when back online.

## Features

* Create, edit, delete notes
* Basic SwiftUI interface
* Sync with remote API when online
* Full offline support using Core Data
* Auto-sync changes to server
* Unit tested logic (ViewModel and Sync)

## Architecture

* MVVM (Model-View-ViewModel)
* Core Data for local persistence
* REST API for server syncing
* Networking with URLSession

## Project Structure

```
NoteApp/
├── NoteAppApp.swift            # Entry point
├── Persistence.swift           # Core Data stack
│
├── Models/
│   └── Note.swift              # Codable model
│   └── CDNote.xcdatamodeld     # Core Data entity
│
├── ViewModels/
│   └── NotesViewModel.swift    # ViewModel logic
│
├── Views/
│   ├── ContentView.swift       # List view
│   ├── AddNoteView.swift       # Create note view
│   └── NoteDetailView.swift    # Edit note view
│
├── CoreData/
│   └── CoreDataManager.swift   # Local DB operations
│
├── Networking/
│   ├── NetworkManager.swift    # API requests
│   └── SyncManager.swift       # Sync logic
│
└── Tests/
    └── NotesAppTests.swift     # Unit tests
```

## API Endpoints (Mock API)

* **GET Notes**:
  `https://67f118d8c733555e24ac27be.mockapi.io/todoapp/v1/notes`

* **POST New Note**:
  `https://67f118d8c733555e24ac27be.mockapi.io/todoapp/v1/notes`

* **PUT Update Note**:
  `https://67f118d8c733555e24ac27be.mockapi.io/todoapp/v1/notes/{id}`

* **DELETE Note**:
  `https://67f118d8c733555e24ac27be.mockapi.io/todoapp/v1/notes/{id}`

## Testing

* Tests are available under `Tests/NotesAppTests`
* Covers ViewModel logic: add, update, delete operations

## Core Data Model Setup

Inside `CDNote.xcdatamodeld`, add an entity `CDNote` with:

| Attribute | Type                       |
| --------- | -------------------------- |
| id        | String                     |
| name      | String                     |
| details   | String                     |
| isFav     | Boolean                    |
| isSynced  | Boolean                    |
| createdAt | Integer 64                 |
| tags      | Transformable (`[String]`) |
