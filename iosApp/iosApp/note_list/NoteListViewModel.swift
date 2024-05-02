//
//  NoteListViewModel.swift
//  iosApp
//
//  Created by Pratik Budhiraja on 4/29/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import shared

// List Kotlin extension functions
extension NoteListScreen {
    // Can only be used inside the NLScreen
    // MainActor: Executed on Main thread. VM deals mostly with updating states and directly updating the UI
    @MainActor
    class NoteListViewModel: ObservableObject {
        private var noteDataSource: NoteDataSource? = nil
        
        private let searchNotes = SearchNotes()
        
        private var notes = [Note]()
        
        // Published -> Mark it as a state of an observable object
        // private(set) -> Can only be 'set' inside the VM
        @Published private(set) var filteredNotes = [Note]()
        @Published var searchText = "" {
            // "onValueChanged"
            didSet {
                self.filteredNotes = searchNotes.execute(notes: self.notes, query: searchText)
            }
        }
        
        @Published private(set) var isSearchActive = false
        
        // Constructor
        init(noteDataSource: NoteDataSource? = nil) {
            self.noteDataSource = noteDataSource
        }
        
        func loadNotes() {
            noteDataSource?.getAllNotes(completionHandler: { notes, error in
                self.notes = notes ?? []
                self.filteredNotes = self.notes
            })
        }
        
        func onToggleSearch() {
            isSearchActive = !isSearchActive
            if !isSearchActive {
                searchText = ""
            }
        }
        
        func deleteNoteById(id: Int64?) {
            if id != nil {
                noteDataSource?.deleteNoteById(id: id!, completionHandler: { error in
                    self.loadNotes()
                })
            }
        }
                
        func setNoteDataSource(noteDataSource: NoteDataSource) {
            self.noteDataSource = noteDataSource
        }
    }
}
