//
//  AddNoteView.swift
//  NotesApp
//
//  Created by Rakesh Yelakanti on 04/05/25.
//
import SwiftUI

struct AddNoteView: View {
    @ObservedObject var viewModel = NotesViewModel()
    @State private var name = ""
    @State private var details = ""
    @State private var tags = ""

    var body: some View {
        VStack {
            TextField("Title", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Details", text: $details)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Tags (comma-separated)", text: $tags)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                let tagArray = tags.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) }
                viewModel.addNote(name: name, details: details, tags: tagArray)
            }) {
                Text("Save Note")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Add Note")
    }
}
