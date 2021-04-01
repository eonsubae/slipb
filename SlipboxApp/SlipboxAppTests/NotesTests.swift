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
        UnitTestHelpers.deletesAllNotes(container: controller.container)
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
    
    func testFetchNotes() {
        let context = controller.container.viewContext
        
        let note = Note(title: "fetch me", context: context)
        
        let request = Note.fetch(NSPredicate.all)
        
        let fetchedNotes = try? context.fetch(request)
        
        XCTAssertTrue(fetchedNotes!.count > 0, "need to have at least one note")
        
        XCTAssertTrue(fetchedNotes?.first == note, "new note should be fetched")
    }
    
    func testSave() {
        // asynchronous testing
        
        expectation(forNotification: .NSManagedObjectContextDidSave, object: controller.container.viewContext) { _ in
            return true
        }
        
        controller.container.viewContext.perform {
            let note = Note(title: "title", context: self.controller.container.viewContext)
            XCTAssertNotNil(note, "note should be there")
        }
        
        waitForExpectations(timeout: 2.0) { (error) in
            XCTAssertNil(error, "saving not complete")
        }
    }
    
    func testDeleteNote() {
        let context = controller.container.viewContext
        let note = Note(title: "note to delete", context: context)
        
        Note.delete(note: note)
        
        let request = Note.fetch(NSPredicate.all)
        let fetchedNotes = try? context.fetch(request)
        
        XCTAssertTrue(fetchedNotes!.count == 0, "core data fetch shuold be empty")
        
        XCTAssertFalse(fetchedNotes!.contains(note), "fetched notes should not contain my deleted note")
    }
}
