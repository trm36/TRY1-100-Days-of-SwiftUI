//
//  ContentView.swift
//  WeGuess
//
//  Created by Taylor on 19 June 2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Button {
                    print("Edit button was tapped")
                } label: {
                    Image(systemName: "pencil")
//                        .frame(minWidth: 50, minHeight: 50.0)
                        .scaleEffect(1.5)
                }
                .buttonStyle(.bordered)
                .padding()
                
                Button {
                    print("Button was tapped")
                    showingAlert = true
                } label: {
                    Text("Tap me!")
                        .padding()
                        .foregroundColor(.white)
                        .background(.red)
                }
                .padding()
                .alert("Important Message", isPresented: $showingAlert) {
                    Button("Delete", role: .destructive) { }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Please read this!")
                }
                
                
                Button("Button 3") { }
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                    .padding()
                HStack {
                    Button("Button 1") { }
                        .buttonStyle(.bordered)
                    Button("Button 2", role: .destructive) { }
                        .buttonStyle(.bordered)
                    Button("Button 3") { }
                        .buttonStyle(.borderedProminent)
                    Button("Button 4", role: .destructive) { }
                        .buttonStyle(.borderedProminent)
                }
                
                
                Button("Delete selection", role: .destructive, action: executeDelete)
                    .padding()
                
                AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                
                //                LinearGradient(gradient: Gradient(stops: [
                //                        Gradient.Stop(color: .white, location: 0.45),
                //                        Gradient.Stop(color: .black, location: 0.55),
                //                    ]), startPoint: .top, endPoint: .bottom)
                
                RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
                
                Color.red
                
                Color.blue
            }
            
            Text("Your content")
                .foregroundStyle(.secondary)
            //                .foregroundColor(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
    
    func executeDelete() {
        print("Now deleting…")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
