//
//  NotesViewModel.swift
//  NotesApp
//
//  Created by Rakesh Yelakanti on 04/05/25.
//
import Foundation
import CoreData

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager()
    
    func fetchNotes() {
        networkManager.fetchNotes { result in
            switch result {
            case .success(let fetchedNotes):
                DispatchQueue.main.async {
                    self.notes = fetchedNotes
                }
            case .failure(let error):
                print("Error fetching notes: \(error.localizedDescription)")
            }
        }
    }
    
    func addNote(name: String, details: String, tags: [String]) {
        let newNote = Note(id: UUID().uuidString, name: name, details: details, isFav: false, createdAt: Int(Date().timeIntervalSince1970), tags: tags)

        // Save locally first
        coreDataManager.saveNoteToCoreData(newNote)

        // Upload to API
        networkManager.createNote(newNote) { result in
            switch result {
            case .success(let uploadedNote):
                DispatchQueue.main.async {
                    self.notes.append(uploadedNote)
                    self.coreDataManager.markNoteAsSynced(uploadedNote)
                }
            case .failure(let error):
                print("Error uploading note: \(error.localizedDescription)")
            }
        }
    }
    func updateNote(_ note: Note) {
        networkManager.updateNote(note) {
            self.fetchNotes()
        }
        coreDataManager.updateNote(note)
    }
}
