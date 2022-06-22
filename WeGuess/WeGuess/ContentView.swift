//
//  ContentView.swift
//  WeGuess
//
//  Created by Taylor on 19 June 2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            let blue = Color(red: 0.1, green: 0.2, blue: 0.45)
            let red = Color(red: 0.76, green: 0.15, blue: 0.26)
            
            RadialGradient(stops: [
                Gradient.Stop(color: blue, location: 0.3),
                Gradient.Stop(color: red, location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15.0) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.semibold))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .foregroundStyle(.secondary)
                    
                    ForEach(0..<3) { i in
                        Button {
                            flagTapped(i)
                        } label: {
                            Image(countries[i])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        
                        .alert(scoreTitle, isPresented: $showingScore) {
                            Button("Continue", action: askQuestion)
                        } message: {
                            Text("Your score is ???")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
       
                Spacer()
                Spacer()
                    
                HStack {
                    Spacer()
                    
                    Text("Score : ???")
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing)
                        .padding(.bottom, 5.0)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
