//
//  ContentView.swift
//  WeModify
//
//  Created by Taylor on 23 June 2022.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.red)
            Text("Custom")
                .titleStyle()
            CapsuleText(text: "First")
                .foregroundColor(.white)
            CapsuleText(text: "Second")
                .foregroundColor(.yellow)
        }
        .font(.body)
        .padding()
        .background(.indigo)
        .padding()
        .background(.blue)
        .padding()
        .background(.green)
        .padding()
        .background(.yellow)
        .padding()
        .background(.orange)
        .padding()
        .background(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
