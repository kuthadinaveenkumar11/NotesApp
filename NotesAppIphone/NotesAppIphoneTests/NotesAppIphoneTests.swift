//
//  NotesAppIphoneTests.swift
//  NotesAppIphoneTests
//
//  Created by Rakesh Yelakanti on 05/05/25.
//
import XCTest
@testable import NotesAppIphone

class NotesAppTests: XCTestCase {
    var viewModel: NotesViewModel!

    override func setUp() {
        super.setUp()
        viewModel = NotesViewModel()
    }

    func testAddNote() {
        viewModel.addNote(name: "Test Note", details: "This is a test", tags: ["test"])
        XCTAssertEqual(viewModel.notes.count, 1)
    }

    func testFetchNotes() {
        viewModel.fetchNotes()
        XCTAssertNotNil(viewModel.notes)
    }
}
