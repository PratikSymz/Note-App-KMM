//
//  NoteListScreen.swift
//  iosApp
//
//  Created by Pratik Budhiraja on 4/29/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

struct NoteListScreen: View {
    
    private var noteDataSource: NoteDataSource
    @StateObject var viewModel: NoteListViewModel = NoteListViewModel(noteDataSource: nil)
    
    // Local states -> MutableStateOf
    @State private var isNoteSelected = false
    @State private var selectedNoteId: Int64? = nil
    
    init(noteDataSource: NoteDataSource) {
        self.noteDataSource = noteDataSource
    }
    
    var body: some View {
        VStack {
            // Box in Compose
            ZStack {
                NavigationLink(
                    destination: NoteDetailScreen(noteDataSource: self.noteDataSource, noteId: selectedNoteId),
                    isActive: $isNoteSelected
                ) {
                    EmptyView()
                }.hidden()
                
                HideableSearchTextField<NoteDetailScreen>(
                    searchText: $viewModel.searchText,
                    isSearchActive: viewModel.isSearchActive,
                    onSearchToggled: viewModel.onToggleSearch,
                    destinationProvider: {
                        NoteDetailScreen(
                            noteDataSource: noteDataSource,
                            noteId: selectedNoteId
                        )
                    }
                )
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 40)
                .padding()
                
                if !viewModel.isSearchActive {
                    Text("All notes")
                        .font(.title2)
                }
            }
            
            List {
                ForEach(viewModel.filteredNotes, id: \.self.id) { note in
                    Button(action: {
                        isNoteSelected = true
                        selectedNoteId = note.id?.int64Value
                    }) {
                        NoteItem(note: note, onDeleteClick: {
                            viewModel.deleteNoteById(id: note.id?.int64Value)
                        })
                    }
                }
            }
            .onAppear {
                viewModel.loadNotes()
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
        }
        .onAppear {
            viewModel.setNoteDataSource(noteDataSource: noteDataSource)
        }
    }
}

#Preview {
    // NoteListScreen()
    EmptyView()
}
