//
//  Note.swift
//  NotesApp
//
//  Created by Rakesh Yelakanti on 04/05/25.
//
import Foundation

struct Note: Codable {
    var id: String?
    var name: String?
    var details: String?
    var isFav: Bool?
    var createdAt: Int?
    var tags: [String]?
    var isSynced: Bool?
}
