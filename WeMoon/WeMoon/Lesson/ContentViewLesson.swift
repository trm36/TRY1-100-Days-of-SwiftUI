//
//  ContentViewLesson.swift
//  WeMoon
//
//  Created by Taylor on 08 October 2022.
//

import SwiftUI

struct ContentViewLesson: View {
    let layout = [
        GridItem(.adaptive(minimum: 80.0, maximum: 120.0)),
    ]
    
    var body: some View {
//        GeometryReader { geo in
//            Image("Example")
//                .resizable()
//                .scaledToFit()
//                .frame(width: geo.size.width * 0.8)
//                .frame(width: geo.size.width, height: geo.size.height)
//        }
        
        
//        ScrollView {
//            LazyVStack(spacing: 10) {
//                ForEach(0..<100) {
//                    CustomText("Item \($0)")
//                        .font(.title)
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
        
        
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink {
//                    Text("Detail \(row)")
//                } label: {
//                    Text("Row \(row)")
//                }
//            }
//            .navigationTitle("SwiftUI")
//        }
        
        
//        Button("Decode JSON") {
//            let input = """
//            {
//                "name": "Taylor Swift",
//                "address": {
//                    "street": "555 Taylor Swift Avenue",
//                    "city": "Nashville",
//                    "state": "TN"
//                }
//            }
//            """
//
//            let data = Data(input.utf8)
//            guard let user = try? JSONDecoder().decode(User.self, from: data) else { return }
//            print(user.address.street)
//        }
        
        
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct ContentViewLesson_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewLesson()
    }
}

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
    let state: String
}

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText \(text)")
        self.text = text
    }
}
