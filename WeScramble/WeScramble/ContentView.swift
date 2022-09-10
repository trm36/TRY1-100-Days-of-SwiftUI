//
//  ContentView.swift
//  WeScramble
//
//  Created by Taylor on 14 July 2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .onSubmit(addNewWord)
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
                    newWord = ""
                }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private func startGame() {
        print("🟢 starting game")
        let errorMessage = "Could not load start.txt from bundle."
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") else { fatalError(errorMessage) }
        guard let startWords = try? String(contentsOf: startWordsURL) else { fatalError(errorMessage) }
        
        let allWords = startWords.components(separatedBy: .newlines)
        guard let selectedWord = allWords.randomElement() else { fatalError(errorMessage) }
        print("🟢 selected - \(selectedWord)")
        rootWord = selectedWord
    }
    
    private func addNewWord() {
        let guessedWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard guessedWord.count > 0 else {
            wordError(title: "No Word", message: "You actually have to guess something.")
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
        
        newWord = ""
    }
    
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
