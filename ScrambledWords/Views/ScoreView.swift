//
//  ScoreView.swift
//  ScrambledWords
//
//

import SwiftUI

struct ScoreView: View {
    
    let score : Int
    let questionCount:Int
    
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            VStack{
                Text("Final Score")
                    .foregroundStyle(.white)
                    .font(.system(size: 26,weight: .bold))
                Text("Score: \(score)/\(questionCount) ")
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ScoreView(score: 2,questionCount: 3)
}
