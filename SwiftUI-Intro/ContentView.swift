//
//  ContentView.swift
//  SwiftUI-Intro
//
//  Created by Maitree Bain on 12/3/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import SwiftUI

// [1, 2, 3].map(transform: { $0 + 1 })
// [1, 2, 3].map { $0 + 1 }

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        
        VStack {
            HStack {
                Image(systemName: "magnifyingglass.circle.fill")
                    .padding()
                
                TextField("Search Articles", text: .constant(""))
                    .padding()
                    .background(colorScheme == .light ? Color.init(white: 0.9) : Color.init(white: 0.1) )
                    .cornerRadius(10)
                    .padding()
                
            }
            
            Picker("Category", selection: .constant(0)) {
                Text("Food")
                Text("Museums")
                Text("Shops")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            List {
                Section(header: Text("Section 1")) {
                    RowView()
                    RowView()
                    RowView()
                }
                Section(header: Text("Section 2")) {
                    RowView()
                    RowView()
                    RowView()
                }
            }
        }
        .navigationBarTitle("Explore", displayMode: .inline)
        .navigationBarItems(trailing:
            HStack.init(spacing: 16) {
                Button(action: {}) {
                    //                        Text("Edit")
                    Image(systemName: "pencil.circle")
                }
                Button(action: {}) {
                    Image(systemName: "plus")
                }
        })
    }
}



struct RowView: View {
    var body: some View {
        HStack.init(alignment: .center, spacing: 8) {
            VStack.init(alignment: .leading, spacing: 20) {
                Text("Hello, World!")
                Text("Pancakes")
            }
            Button(action: { }) {
                Text("Button")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ContentView()
            }.environment(\.colorScheme, .light)
            
            NavigationView {
                ContentView()
            }.environment(\.colorScheme, .dark)
        }
    }
}
