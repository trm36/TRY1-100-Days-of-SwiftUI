//
//  ContentViewLesson.swift
//  WeExpense
//
//  Created by Taylor on 04 October 2022.
//

import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}

struct ContentViewLesson: View {
    
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @AppStorage("tapCount") private var tapCount = 0
    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                
                Group {
                    Spacer()
                    Spacer()
                    
                    Button("Show Sheet") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        SecondView(name: "World")
                    }
                }
                
                Group {
                    Spacer()
                    Spacer()
                    
                    Button("Tap count: \(tapCount)") {
                        tapCount += 1
                    }
                }
                
                Group {
                    Spacer()
                    Spacer()
                    
                    Button("Save User") {
                        let encoder = JSONEncoder()
                        
                        if let data = try? encoder.encode(user) {
                            UserDefaults.standard.set(data, forKey: "UserData")
                        }
                    }
                }
                
            }
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentViewLesson_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewLesson()
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    let name: String
    
    var body: some View {
        Button("Dismiss \(name)") {
            dismiss()
        }
    }
}
