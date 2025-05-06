
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes, id: \.id) { note in
                    NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                        Text(note.name!)
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddNoteView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear { viewModel.fetchNotes() }
        }
    }
}
