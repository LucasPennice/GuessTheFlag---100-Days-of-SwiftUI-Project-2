//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lucas Pennice on 07/02/2024.
//

import SwiftUI

func getScoreTitle(_ correctGuess: Bool) -> String {
    if correctGuess {return "Correct"}
    
    return "Wrong"
}

struct AppColors {
    static let gray = Color(red: 24/256, green: 26/256, blue: 28/256)
    static let darkGray = Color(red: 9/256, green: 12/256, blue: 2/256)
}

struct ContentView: View {
    @State private var showAlert = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [AppColors.gray, AppColors.darkGray], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack (spacing: 20){
                VStack{
                    Text("Tap the flag of")
                        .font(.title)
                        .foregroundStyle(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                }
                
                ForEach(0..<3){ number in
                    Button{handleFlagTap(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.rect(cornerRadius: 12))
                    }
                }
                
                Text("Score: \(score) points")
                    .font(.title)
                    .foregroundStyle(.white)
            }
            .padding([.horizontal],40)
            .padding([.vertical],20)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
        }
        .alert(scoreTitle, isPresented: $showAlert){
            Button("Ok") {shuffle()}
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func shuffle(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func handleFlagTap(_ tappedFlagIdx: Int){
        let correctGuess = tappedFlagIdx == correctAnswer
        
        if correctGuess {score += 100}
        
        scoreTitle = getScoreTitle(correctGuess)
            
        showAlert = true
    }
}

#Preview {
    ContentView()
}
