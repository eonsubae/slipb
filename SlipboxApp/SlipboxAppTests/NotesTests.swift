//
//  NotesTests.swift
//  SlipboxAppTests
//
//  Created by KRENGLSSEAN on 2021/03/30.
//

import XCTest
@testable import SlipboxApp

class NotesTests: XCTestCase {

    var controller: PersistenceController!
    
    override func setUp() {
        super.setUp()
        
        controller = PersistenceController.empty
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddNote() {
        let context = controller.container.viewContext
        let title = "new"
        let note = Note(title: title, context: context)
        
        XCTAssertTrue(note.title == title)
        
        XCTAssertNotNil(note.creationDate, "note should have a date")
    }
    
    func testUpdateNote() {
        let context = controller.container.viewContext
        let note = Note(title: "old", context: context)
        note.title = "new"
        
        XCTAssertTrue(note.title == "new")
        XCTAssertFalse(note.title == "old", "note's title not correctly updated")
    }
}
