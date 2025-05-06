//
//  NetworkManager.swift
//  NotesApp
//
//  Created by Rakesh Yelakanti on 04/05/25.
//
import Foundation

class NetworkManager {
    let baseURL = "https://67f118d8c733555e24ac27be.mockapi.io/todoapp/v1/notes"
    
    func fetchNotes(completion: @escaping (Result<[Note], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let notes = try JSONDecoder().decode([Note].self, from: data)
                    completion(.success(notes))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func createNote(_ note: Note, completion: @escaping (Result<Note, Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(note)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let createdNote = try JSONDecoder().decode(Note.self, from: data)
                    completion(.success(createdNote))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    func updateNote(_ note: Note, completion: @escaping () -> Void) {
        guard let url = URL(string: "\(baseURL)/\(String(describing: note.id))") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(note)

        URLSession.shared.dataTask(with: request) { _, _, _ in
            completion()
        }.resume()
    }

}
