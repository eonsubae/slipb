//
//  ContentView.swift
//  SlipboxPad
//
//  Created by KRITSSEAN on 2021/03/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: Note.fetch(NSPredicate.all)) private var notes: FetchedResults<Note>

    var body: some View {
        VStack {
            Text("Notes").font(.title)
            Button(action: {
                _ = Note(title: "added on phone", context: viewContext)
            }) {
                Label("Add Item", systemImage: "plus")
            }
            
            List {
                ForEach(notes) { note in
                    Text("title : \(note.title ?? "") date \(note.creationDate ?? Date(), formatter: itemFormatter)")
                }
                //            .onDelete(perform: deleteItems)
            }
//            .toolbar {
                //            #if os(iOS)
                //            EditButton()
                //            #endif
//            }
        }
    }

    /*
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    */
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
