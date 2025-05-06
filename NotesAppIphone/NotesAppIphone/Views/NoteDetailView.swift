
import SwiftUI

struct NoteDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String
    @State private var details: String
    @State private var tags: String
    @State private var isFav: Bool
    var note: Note
    @ObservedObject var viewModel: NotesViewModel

    init(note: Note, viewModel: NotesViewModel) {
        self.note = note
        self.viewModel = viewModel
        _name = State(initialValue: note.name!)
        _details = State(initialValue: note.details!)
        _tags = State(initialValue: note.tags?.joined(separator: ",") ?? "")
        _isFav = State(initialValue: note.isFav!)
    }

    var body: some View {
        Form {
            TextField("Title", text: $name)
            TextField("Details", text: $details)
            TextField("Tags (comma separated)", text: $tags)
            Toggle("Favorite", isOn: $isFav)
            
            Button("Save Changes") {
                let updatedNote = Note(
                    id: note.id,
                    name: name,
                    details: details,
                    isFav: isFav,
                    createdAt: note.createdAt,
                    tags: tags.split(separator: ",").map { String($0) }
                )
                viewModel.updateNote(updatedNote)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationTitle("Edit Note")
    }
}
