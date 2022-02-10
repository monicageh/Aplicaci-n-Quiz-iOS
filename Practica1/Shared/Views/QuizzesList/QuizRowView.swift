//
//  QuizRowView.swift
//  Practica1
//
//  Created by Pedro Llorente Flores on 21/9/21.
//

import SwiftUI

struct QuizRowView: View{
    var quizItem: QuizItem
   
    var body: some View{
        let aurl = quizItem.attachment?.url
        let anivm = NetworkImageViewModel(url: aurl)
        
        let uurl = quizItem.author?.photo?.url
        let univm = NetworkImageViewModel(url: uurl)
        
        return
    HStack{
        NetworkImageView(viewModel: anivm)
        .frame(width: 120, height: 120)
        .clipShape(Circle())
        .overlay(Circle().stroke(lineWidth: 3))
    
        VStack{
            Text(quizItem.question)
                .font(.headline)
            
            Image(quizItem.favourite ? "star_yellow" : "star_grey")
                .resizable()
                .frame(width: 40, height: 40)
                .scaledToFit()
            
            Text(quizItem.author?.username ?? "anónimo")
                .font(.callout)
                .foregroundColor(.green)
            NetworkImageView(viewModel: univm)
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(lineWidth: 4))
        }
            }
        
    }
}

