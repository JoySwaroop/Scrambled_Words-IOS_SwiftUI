//
//  ContentView.swift
//  ScrambledWords
//

import SwiftUI

struct GameView: View {
    
//    @State var letters:[Letter] = [
//        Letter(id: 0, text: "A"),
//        Letter(id: 1, text: "G"),
//        Letter(id: 2, text: "R"),
//        Letter(id: 3, text: "N"),
//        Letter(id: 4, text: "O"),
//        Letter(id: 5, text: "E")
//        
//    ]
    
    @State private var gussedLetters:[Letter] = []
    @State private var showSuccess = false
    @State private var showFailure = false
    @State private var score = 0
    
//    let correctAnswer = "ORANGE"
    @State var questions:[Question] = Question.generateQuestion()
    
    @State private var currentQuestionIndex = 0
    @State private var showFinalScore = false
    
    var body: some View {
        
        
            GeometryReader { proxy in
                ZStack{
                    Color.background
                        .ignoresSafeArea()
                    VStack {
                        VStack {
                            Spacer()
                            Image(questions[currentQuestionIndex].image)
                                .resizable()
                                .frame(width: 100,height: 100)
                            Spacer()
                            HStack {
                                ForEach(gussedLetters) { gussedLetter in
                                    VStack {
                                        
                                        LetterView(letter: gussedLetter)
                                            .onTapGesture{
                                                if  let index = gussedLetters.firstIndex(of: gussedLetter){
                                                    gussedLetters.remove(at: index)
                                                    questions[currentQuestionIndex].scrambledLetters[gussedLetter.id].text = gussedLetter.text
                                                }
                                                
                                            }
                                        
                                        Rectangle()
                                            .fill(.white)
                                            .frame(width: 25,height: 2)
                                        
                                    }
                                    
                                }
                            }
                            .padding(.bottom,20)
                        }
                        .frame(width: proxy.size.width*0.9,height: proxy.size.width*0.9)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8).stroke(Color.border, lineWidth: 2)
                        }
                        Text("Score: \(score)")
                            .font(.system(size: 15))
                            .foregroundStyle(Color.white)
                            .padding(.top)
                        HStack{
                            ForEach(Array(questions[currentQuestionIndex].scrambledLetters.enumerated()), id: \.1){
                                index, letter in
                                LetterView(letter: letter)
                                    .onTapGesture {
                                        if !letter.text.isEmpty{
                                            gussedLetters.append(letter)
                                            questions[currentQuestionIndex].scrambledLetters[index].text = ""
                                            if gussedLetters.count == questions[currentQuestionIndex].scrambledLetters.count{
                                                //                                            var gussedAnswer = ""
                                                //                                            for gussedLetter in gussedLetters {
                                                //                                                gussedAnswer = gussedAnswer +  gussedLetter.text
                                                //                                            }
                                                
                                                //                                            let gussedAnswer = gussedLetters.map{$0.text}.joined()
                                                
                                                let textsArray = gussedLetters.map{
                                                    x in x.text
                                                }
                                                
                                                let gussedAnswer = textsArray.joined()
                                                
                                                if gussedAnswer == questions[currentQuestionIndex].answer {
                                                    showSuccess = true
                                                    score = score + 1
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:{
                                                        showSuccess = false
                                                        if currentQuestionIndex == questions.count-1{
                                                            showFinalScore = true
                                                           
                                                        }else{
                                                            currentQuestionIndex = currentQuestionIndex + 1
                                                        }
                                                        
                                                       
                                                    })
                                                } else{
                                                    showFailure = true
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:{
                                                        showFailure = false
                                                        if currentQuestionIndex == questions.count-1{
                                                            showFinalScore = true
                                                           
                                                        }else{
                                                            currentQuestionIndex = currentQuestionIndex + 1
                                                        }
                                                        
                                                    })
                                                }
                                                gussedLetters.removeAll()
                                            }
                                        }
                                    }
                            }
                            
                            
                        }
                    }
                    if showSuccess {
                        VStack {
                            Image("tick")
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background(.black.opacity(0.3))
                    }
                    if showFailure {
                        VStack {
                            Image("cross")
                        }
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .background(.black.opacity(0.3))
                    }
                }
            }
            .sheet(isPresented: $showFinalScore) {
                questions = Question.generateQuestion()
                currentQuestionIndex = 0
                score = 0
            
            } content: {
                ScoreView(score: score, questionCount: questions.count)
            }

      


        
    }
}

#Preview {
    GameView()
}


