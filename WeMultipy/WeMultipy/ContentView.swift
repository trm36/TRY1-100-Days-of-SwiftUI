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
        return multiplicandFirst ? "\(multiplicand)  ⨉  \(multiplier)  =  ??" : "\(multiplier)  ⨉  \(multiplicand)  =  ??"
    }
    
    init(multiplicationTable: Int) {
        self.multiplier = multiplicationTable
    }
}

struct ContentView: View {
    
    @State private var multiplicationTable: Int? = 5
    @State private var questionsCount: Int? = nil
    private var questionsCountOptions: [Int] = [5, 10, 20]
    @State private var questions: [MultiplicationQuestion]? = nil
    @State var questionIndex: Int = 0
    @State var score: Int = 0
    @State var enteredAnswer: Int? = nil
    
    @FocusState private var inputIsFocused: Bool
    
    var body: some View {
        GeometryReader { geometery in
            if multiplicationTable == nil {
                VStack {
                    // Question View
                    Text("Select the multiplication table")
                        .frame(width: geometery.size.width, height: geometery.size.height * 0.3)
                    
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
                            }
                            .foregroundColor(.white)
                            .frame(minWidth: geometery.size.width / 3.0, minHeight: geometery.size.height / 12.0)
                            .background(LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            
                            Spacer()
                            
                            Button {
                                multiplicationTable = indexB
                            } label: {
                                Text("\(indexB)")
                                    .font(.title)
                                    .bold()
                            }
                            .foregroundColor(.white)
                            .frame(minWidth: geometery.size.width / 3.0, minHeight: geometery.size.height / 12.0)
                            .background(LinearGradient(gradient: Gradient(colors: [.yellow, .green]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
            } else if questionsCount == nil {
                VStack {
                    // Question View
                    Text("Select the number of questions")
                        .frame(width: geometery.size.width, height: geometery.size.height * 0.3)
                    
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
                        }
                        .foregroundColor(.white)
                        .frame(minWidth: geometery.size.width / 3.0, minHeight: geometery.size.height / 12.0)
                        .background(LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    }
                }
            } else {
                VStack {
                    // Question View
                    let question = questions?[questionIndex]
                    Text(question?.questionText ?? "NO QUESTION")
                        .frame(width: geometery.size.width, height: geometery.size.height * 0.3)
                        .font(.title)
                    
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
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 24.0)
                        .focused($inputIsFocused)
                    
                    Button {
                        if let enteredAnswer = enteredAnswer, let question = question {
//                            inputIsFocused = false
                            print("\(enteredAnswer)")
                            if question.product == enteredAnswer {
                                print("\(question.questionText) - 🟢 CORRECT")
                            } else {
                                print("\(question.questionText) - 🔴 WRONG")
                            }
                            self.enteredAnswer = nil
                            questionIndex += 1
//                            inputIsFocused = true
                        } else {
                            print("❌ No Answer")
                        }
                        
                    } label: {
                        Text("Submit")
                            .font(.title)
                            .bold()
                    }
                    .foregroundColor(.white)
                    .frame(minWidth: geometery.size.width / 3.0, minHeight: geometery.size.height / 12.0)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
//                    ForEach(questionsCountOptions, id: \.self) { i in
//                        Button {
//                            questionsCount = i
//
//                        } label: {
//                            Text("\(i)")
//                                .font(.title)
//                                .bold()
//                        }
//                        .foregroundColor(.white)
//                        .frame(minWidth: geometery.size.width / 3.0, minHeight: geometery.size.height / 12.0)
//                        .background(LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
//                    }
                }
            }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
