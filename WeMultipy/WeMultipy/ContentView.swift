//
//  ContentView.swift
//  WeMultipy
//
//  Created by Taylor on 29 September 2022.
//

import SwiftUI

struct MultiplicationQuestion {
    private var multiplicand: Int = Int.random(in: 0...12)
    private var multiplier: Int
    var product: Int {
        return multiplicand * multiplier
    }
    private var multiplicandFirst: Bool = Bool.random()
    
    
    var questionText: String {
        return multiplicandFirst ? "\(multiplicand)  ⨉  \(multiplier)  =  " : "\(multiplier)  ⨉  \(multiplicand)  =  "
    }
    
    init(multiplicationTable: Int) {
        self.multiplier = multiplicationTable
    }
}

struct ContentView: View {
    
    @State private var multiplicationTable: Int? = nil
    @State private var questionsCount: Int? = nil
    private var questionsCountOptions: [Int] = [5, 10, 20]
    @State private var questions: [MultiplicationQuestion]? = nil
    @State var questionIndex: Int = 0
    @State var score: Int = 0
    @State var enteredAnswer: Int? = nil
    @State var endOfGameAlertShown: Bool = false
    
    @FocusState private var inputIsFocused: Bool
    
    var body: some View {
        GeometryReader { geometery in
            let size = geometery.size
            if multiplicationTable == nil {
                multiplicationTableEntryView(size: size)
            } else if questionsCount == nil {
                questionCountEntry(size: size)
            } else {
                questionView(size: size)
            }
        }
    }
    
    private func multiplicationTableEntryView(size: CGSize) -> some View {
        VStack {
            // Question View
            Text("Select the multiplication table")
                .frame(width: size.width, height: size.height * 0.3)
            
            // Answer View
            ForEach(0..<7) { i in
                HStack {
                    Spacer()
                    
                    let indexA = i * 2
                    let indexB = indexA + 1
                    
                    Button {
                        multiplicationTable = indexA
                    } label: {
                        Text("\(indexA)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .frame(minWidth: size.width / 3.0, minHeight: size.height / 12.0)
                            .background(LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    }
                    
                    Spacer()
                    
                    Button {
                        multiplicationTable = indexB
                    } label: {
                        Text("\(indexB)")
                            .font(.title)
                            .bold().foregroundColor(.white)
                            .frame(minWidth: size.width / 3.0, minHeight: size.height / 12.0)
                            .background(LinearGradient(gradient: Gradient(colors: [.yellow, .green]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
    
    private func questionCountEntry(size: CGSize) -> some View {
        VStack {
            // Question View
            Text("Select the number of questions")
                .frame(width: size.width, height: size.height * 0.3)
            
            // Answer View
            ForEach(questionsCountOptions, id: \.self) { i in
                Button {
                    questionsCount = i
                    generateQuestions()
                    inputIsFocused = true
                } label: {
                    Text("\(i)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .frame(minWidth: size.width / 3.0, minHeight: size.height / 12.0)
                        .background(LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
            }
        }
    }
    
    private func questionView(size: CGSize) -> some View {
        let question = questions?[safe: questionIndex]
        let questionText: String
        
        if let question = question {
            questionText = question.questionText + (String(enteredAnswer) ?? "??")
        } else {
            questionText = "⚠️ NO QUESTION"
        }
        
        return ZStack {
            VStack {
                // Question View
                Text(questionText)
                    .frame(width: size.width, height: size.height * 0.3)
                    .font(.largeTitle)
                
                // Answer View
                TextField("Answer", text: Binding(
                    get: {
                        if let enteredAnswer = enteredAnswer {
                            return String(enteredAnswer)
                        } else {
                            return ""
                        }
                    },
                    set: { enteredAnswer = Int($0) }))
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .keyboardType(.numberPad)
                    .padding(.horizontal, 24.0)
                    .focused($inputIsFocused)
                
                Button {
                    if let enteredAnswer = enteredAnswer, let question = question {
                        if question.product == enteredAnswer {
                            print("\(question.questionText) - 🟢 CORRECT")
                            score += 100
                        } else {
                            print("\(question.questionText) - 🔴 WRONG")
                            score += 0
                        }
                        self.enteredAnswer = nil
                        
                        if let questionsCount = questionsCount, questionIndex >= questionsCount - 1 {
                            endOfGameAlertShown = true
                        } else {
                            questionIndex += 1
                        }
                        
                    } else {
                        print("❌ No Answer")
                    }
                    
                } label: {
                    Text("Submit")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .frame(minWidth: size.width / 3.0, minHeight: size.height / 12.0)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
                .padding(.top)
            }
            
            Text("Score: \(score)")
        }
        .alert("Game Over", isPresented: $endOfGameAlertShown) {
            Button("🔄 Try Again", action: playAgain)
            Button("🆕 New Game", action: resetGame)
                .foregroundColor(.green)
        } message: {
            Text("You got \(score) out of \((questionsCount ?? 0) * 100). Play again?")
        }
    }
    
    private func generateQuestions() {
        guard let multiplicationTable = multiplicationTable,
              let questionsCount = questionsCount else {
            self.questions = nil
            return
        }
        
        self.questions = []
        
        for _ in 0..<questionsCount {
            let question = MultiplicationQuestion(multiplicationTable: multiplicationTable)
            print("\(question.questionText)")
            self.questions?.append(question)
        }
    }
    
    private func resetGame() {
        multiplicationTable = nil
        questionsCount = nil
        questions = nil
        questionIndex = 0
        score = 0
        endOfGameAlertShown = false
    }
    
    private func playAgain() {
        generateQuestions()
        questionIndex = 0
        score = 0
        endOfGameAlertShown = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension String {
    init?<T : CustomStringConvertible>(_ value : T?) {
        guard let value = value else { return nil }
        self.init(describing: value)
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
