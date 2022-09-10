//
//  ContentView.swift
//  WeScramble
//
//  Created by Taylor on 14 July 2022.
//

import SwiftUI

struct ContentView: View {
    private var minimumLength = 3
    
    @State private var usedWords = [String]()
    @State private var score: Int = 0
    @State private var rootWord = ""
    @State private var enteredGuess = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $enteredGuess)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .onSubmit(addNewWord)
                }
                
                Section {
                    Text("Score: \(score)")
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {
                    enteredGuess = ""
                }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Restart", action: startGame)
            }
        }
    }
    
    private func startGame() {
        let errorMessage = "Could not load start.txt from bundle."
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") else { fatalError(errorMessage) }
        guard let startWords = try? String(contentsOf: startWordsURL) else { fatalError(errorMessage) }
        
        let allWords = startWords.components(separatedBy: .newlines)
        guard let selectedWord = allWords.randomElement() else { fatalError(errorMessage) }
        rootWord = selectedWord
        enteredGuess = ""
        score = 0
        usedWords = []
    }
    
    private func addNewWord() {
        let guessedWord = enteredGuess.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard isNotRootWord(string: guessedWord) else {
            wordError(title: "Same As Root", message: "You've gotta come up with your own word.")
            return
        }
        
        guard isMinimumLength(string: guessedWord) else {
            wordError(title: "Word Too Short", message: "You've gotta try harder than that!")
            return
        }
        
        guard isWord(string: guessedWord) else {
            wordError(title: "Word Doesn't Exist", message: "You can't just make them up, you know!")
            return
        }
        
        guard isOrignial(string: guessedWord) else {
            wordError(title: "Word Used Already", message: "Be more original.")
            return
        }
        
        guard isPossible(string: guessedWord) else {
            wordError(title: "Word Not Possible", message: "You can't spell \(guessedWord) from \(rootWord)")
            return
        }
        
        withAnimation {
            usedWords.insert(guessedWord, at: 0)
        }
        
        score += score(word: guessedWord)
        enteredGuess = ""
    }
    
    // MARK: - SCORE WORD
    
    private func score(word: String) -> Int {
        let numberOfCorrectWords = usedWords.count + 1 //IF THE COUNT IS ZERO, MULTIPLIER IS 1
        return word.count * word.count * numberOfCorrectWords
    }
    
    // MARK: - VALIDATE WORD
    
    private func isOrignial(string: String) -> Bool {
        return !usedWords.contains(string)
    }
    
    private func isWord(string: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: string.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: string, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func isPossible(string: String) -> Bool {
        var tempRoot = rootWord
        
        for character in string {
            guard let index = tempRoot.firstIndex(of: character) else { return false }
            tempRoot.remove(at: index)
        }
        
        return true
    }
    
    private func isNotRootWord(string: String) -> Bool {
        return string != rootWord
    }
    
    private func isMinimumLength(string: String) -> Bool {
        return string.count >= minimumLength
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
