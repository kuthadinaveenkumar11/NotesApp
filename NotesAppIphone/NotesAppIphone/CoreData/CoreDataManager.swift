//
//  CoreDataManager.swift
//  NotesApp
//
//  Created by Rakesh Yelakanti on 04/05/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    
    init() {
        container = NSPersistentContainer(name: "NotesAppIphone")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func saveNoteToCoreData(_ note: Note) {
        let context = container.viewContext
        let cdNote = CDNote(context: context)
        cdNote.id = note.id
        cdNote.name = note.name
        cdNote.details = note.details
        cdNote.isFav = note.isFav!
        cdNote.createdAt = Int64(note.createdAt!)
        cdNote.tags = note.tags
        
        do {
            try context.save()
        } catch {
            print("Error saving note: \(error.localizedDescription)")
        }
    }
    func updateNote(_ note: Note) {
        let request: NSFetchRequest<CDNote> = CDNote.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", note.id!)

        do {
            let cdNotes = try context.fetch(request)
            if let cdNote = cdNotes.first {
                cdNote.name = note.name
                cdNote.details = note.details
                cdNote.isFav = note.isFav!
                cdNote.tags = note.tags
                cdNote.isSynced = false

                saveContext()
            }
        } catch {
            print("Error updating note: \(error)")
        }
    }
}
import CoreData

extension CoreDataManager {
    func fetchUnsyncedNotes() -> [Note] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<CDNote> = CDNote.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isSynced == %@", NSNumber(value: false))

        do {
            let cdNotes = try context.fetch(fetchRequest)
            return cdNotes.map { cdNote in
                return Note(id: cdNote.id ?? UUID().uuidString,
                            name: cdNote.name ?? "",
                            details: cdNote.details ?? "",
                            isFav: cdNote.isFav,
                            createdAt: Int(cdNote.createdAt),
                            tags: cdNote.tags ?? [])
            }
        } catch {
            print("Error fetching unsynced notes: \(error.localizedDescription)")
            return []
        }
    }
    func markNoteAsSynced(_ note: Note) {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<CDNote> = CDNote.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", note.id!)

        do {
            if let cdNote = try context.fetch(fetchRequest).first {
                cdNote.isSynced = true  // Mark it as synced
                try context.save()
            }
        } catch {
            print("Error marking note as synced: \(error.localizedDescription)")
        }
    }
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
}
