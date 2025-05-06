//
//  File.swift
//  NotesApp
//
//  Created by Rakesh Yelakanti on 04/05/25.
//
import Foundation
import CoreData

class SyncManager {
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager()
    
    func syncOfflineNotes() {
        let offlineNotes = coreDataManager.fetchUnsyncedNotes()
        
        for note in offlineNotes {
            networkManager.createNote(note) { result in
                switch result {
                case .success(let syncedNote):
                    self.coreDataManager.markNoteAsSynced(syncedNote)
                case .failure(let error):
                    print("Sync error: \(error.localizedDescription)")
                }
            }
        }
    }
}
