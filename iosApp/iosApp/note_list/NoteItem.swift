//
//  NoteItem.swift
//  iosApp
//
//  Created by Pratik Budhiraja on 4/30/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

struct NoteItem: View {
    
    /*
        note: Note,
        backgroundColor: Color,
        onNoteClick: () -> Unit,
        onDeleteClick: () -> Unit
     */
    
    var note: Note
    var onDeleteClick: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(note.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: onDeleteClick) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }.padding(.bottom, 3)
            
            Text(note.content)
                .fontWeight(.light)
                .padding(.bottom, 3)
            
            HStack {
                Spacer()
                Text(DateTimeUtil().formatNoteDate(dateTime: note.created))
                    .font(.footnote)
                    .fontWeight(.light)
            }
        }
        .padding()
        .background(Color(hex: note.colorHex))
        .clipShape(RoundedRectangle(cornerRadius: 5.0))
    }
}

#Preview {
    NoteItem(
        note: Note(id: nil, title: "NoteTitle", content: "Note Content", colorHex: 0xFF2341, created: DateTimeUtil().now()),
        onDeleteClick: {}
    )
}
