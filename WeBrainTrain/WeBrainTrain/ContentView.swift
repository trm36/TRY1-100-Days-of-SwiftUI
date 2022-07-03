//
//  ContentView.swift
//  WeBrainTrain
//
//  Created by Taylor on 02 July 2022.
//

import SwiftUI

struct ContentView: View {
    
    private let numberOfQuestionsAsked: Int = 10
    
    private enum RockPaperScissors: String, CaseIterable {
        case rock = "🪨"
        case paper = "📄"
        case scissors = "✂️"
        
        func emoji(style: EmojiStyle) -> String {
            switch style {
            case .items:
                return rawValue
            case .hands:
                switch self {
                case .rock:
                    return "✊"
                case .paper:
                    return "🖐"
                case .scissors:
                    return "✌️"
                }
            }
        }
    }
    
    private enum WinLose: String, CaseIterable {
        case win = "WIN"
        case lose = "LOSE"
    }
    
    private enum EmojiStyle: String, CaseIterable {
        case items = "🪨📄✂️"
        case hands = "✊🖐✌️"
        
        var id: Self { self }
    }
    
    private var correctAnswer: RockPaperScissors {
        switch selectedWinLose {
        case .win:
            switch selectedRockPaperScissors {
            case .rock:
                return .paper
            case .paper:
                return .scissors
            case .scissors:
                return .rock
            }
            
        case .lose:
            switch selectedRockPaperScissors {
            case .rock:
                return .scissors
            case .paper:
                return .rock
            case .scissors:
                return .paper
            }
        }
    }
    
    // MARK: - CURRENT QUESTION PROPERTEIS
    @State private var selectedRockPaperScissors = RockPaperScissors.allCases.randomElement()!
    @State private var selectedWinLose = WinLose.allCases.randomElement()!
    
    // MARK: - GAME INFO PROPERTIES
    @State private var emojiStyleBool: Bool = false
    @State private var questionIndex: Int = 1
    @State private var score: Int = 0
    
    private var emojiStyle: EmojiStyle {
        emojiStyleBool ? .hands : .items
    }
    
    // MARK: - ANSWER ALERT PROPERTIES
    @State private var showingAnswerAlert = false
    @State private var showingFinalScoreAlert = false
    @State private var answerAlertTitle = ""
    @State private var answerAlertMessage = ""
    
    
    
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                Gradient.Stop(color: .red, location: 0.16),
                Gradient.Stop(color: .orange, location: 0.32),
                Gradient.Stop(color: .yellow, location: 0.48),
                Gradient.Stop(color: .green, location: 0.64),
                Gradient.Stop(color: .blue, location: 0.80),
                Gradient.Stop(color: .indigo, location: 0.96),
            ], center: .top, startRadius: 150.0, endRadius: 700.0)
                .ignoresSafeArea()
            
            VStack {
                // INFORMATION STACK
                HStack {
                    Text("❓  \(questionIndex)")
                        .padding(10.0)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                    
                    Spacer()
                    
                    Text("\(score)  🪙")
                        .padding(10.0)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                }
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.white)
                .padding()
                
                Spacer()
                
                VStack {
                    // QUESTION STACK
                    VStack(spacing: 4.0) {
                        Text(selectedRockPaperScissors.emoji(style: emojiStyle))
                            .font(.system(size: 60.0))
                        Text(selectedWinLose.rawValue)
                            .font(.system(size: 40.0, weight: .heavy))
                            .foregroundColor(.white)
                            .padding(.bottom, 12.0)
                    }
                    
                    // ANSWER STACK
                    VStack(spacing: 18.0) {
                        ForEach(RockPaperScissors.allCases, id: \.self) { value in
                            Button {
                                answerButtonTapped(value)
                            } label: {
                                Text(value.emoji(style: emojiStyle))
                                    .font(.system(size: 40.0))
                                    .padding(.vertical)
                                    .padding(.horizontal, 50.0)
                                    
                            }
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        }
                    }
                    .alert(answerAlertTitle, isPresented: $showingAnswerAlert) {
                        Button("Continue", action: askQuestion)
                    } message: {
                        Text(answerAlertMessage)
                    }
                    .alert(answerAlertTitle, isPresented: $showingFinalScoreAlert) {
                        Button("New Game", action: resetGame)
                    } message: {
                        Text(answerAlertMessage)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20.0)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                .padding()
                
                Spacer()
                Spacer()
                
                HStack {
                    Text("🪨📄✂️")
                        .padding(10.0)
                        .background(emojiStyleBool ? .ultraThinMaterial : .thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                    
                    Spacer()
                    
                    Toggle("Choose Emoji Style", isOn: $emojiStyleBool)
                        .tint(.clear)
                        .labelsHidden()
                    
                    Spacer()
                    
                    Text("✊🖐✌️")
                        .padding(10.0)
                        .background(emojiStyleBool ? .thinMaterial : .ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                }
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.white)
                .padding()
            }
        }
    }
    
    private func resetGame() {
        questionIndex = 1
        score = 0
        selectedRockPaperScissors = RockPaperScissors.allCases.randomElement()!
        selectedWinLose = WinLose.allCases.randomElement()!
    }
    
    private func askQuestion() {
        if questionIndex < numberOfQuestionsAsked {
            selectedRockPaperScissors = RockPaperScissors.allCases.randomElement()!
            selectedWinLose = WinLose.allCases.randomElement()!
            questionIndex += 1
        } else {
            answerAlertTitle = "Final Score"
            answerAlertMessage = "\(score)\n\n90+ · Excellent\n80 - 89 · Very Good\n70 - 79 · Average\n60 - 69 · Below Average\n59- · Fail"
            showingFinalScoreAlert = true
        }
    }
    
    private func answerButtonTapped(_ rockPaperScissors: RockPaperScissors) {
        guard let correctEmjoi = ["✅", "🏆", "🥳", "🎉", "🎊", "🙌"].randomElement() else { return }
        guard let wrongEmjoi = ["❌", "👎", "🚫"].randomElement() else { return }
        
        if rockPaperScissors == correctAnswer {
            answerAlertTitle = "\(correctEmjoi) Correct \(correctEmjoi)"
            score += 10
            answerAlertMessage = "+10\nYour score is: \(score)"
        } else {
            // wrong answer
            answerAlertTitle = "\(wrongEmjoi) Wrong \(wrongEmjoi)"
            score -= 5
            
            var lossDescription = "\(rockPaperScissors.emoji(style: emojiStyle)) does not "
            
            switch selectedWinLose {
            case .win:
                lossDescription.append("win against ")
            case .lose:
                lossDescription.append("lose to ")
            }
            
            lossDescription.append("\(selectedRockPaperScissors.emoji(style: emojiStyle))")
            
            answerAlertMessage = "-5\n\(lossDescription)\nYour score is: \(score)"
        }
        
        showingAnswerAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
