//
//  HideableSearchTextField.swift
//  iosApp
//
//  Created by Pratik Budhiraja on 4/30/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct HideableSearchTextField<Destination: View>: View {
    
//    onCloseClick: () -> Unit
    
    // @Binding removes the need of: onTextChange: (String) -> Void
    @Binding var searchText: String
    var isSearchActive: Bool
    var onSearchToggled: () -> Void
    var destinationProvider: () -> Destination // NavHost -> Destination provider
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .opacity(isSearchActive ? 1 : 0)
                
            if !isSearchActive {
                Spacer()    // Occupy all remaining space, in case the search is not active
            }
            
            Button(action: onSearchToggled) {
                Image(systemName: isSearchActive ? "xmark" : "magnifyingglass")
                    .foregroundColor(.black)
            }
            
            NavigationLink(destination: destinationProvider) {
                Image(systemName: "plus")
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    HideableSearchTextField(
        searchText: .constant("Hello world"),
        isSearchActive: true,
        onSearchToggled: {},
        destinationProvider: { EmptyView() }
    )
}
