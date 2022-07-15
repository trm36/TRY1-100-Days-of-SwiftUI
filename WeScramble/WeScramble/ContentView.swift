//
//  ContentView.swift
//  WeScramble
//
//  Created by Taylor on 14 July 2022.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        List(people, id: \.self) {
            Text($0)
        }
        
        
//        List(0..<5) {
//            Text("Dynamic List \($0)")
//        }
        
        
//        List {
//            Section("Section 0") {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundColor(.accentColor)
//            }
//
//            Section("👋") {
//                Text("Hello, world!")
//                Text("Hello, world!")
//                Text("Hello, world!")
//            }
//
//            Section("Dynamic") {
//                ForEach(0..<5) {
//                    Text("Dynamic row \($0)")
//                }
//            }
//        }
//        .listStyle(.grouped)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
