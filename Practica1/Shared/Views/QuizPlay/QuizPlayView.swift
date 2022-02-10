//
//  QuizPlayView.swift
//  Practica1
//
//  Created by Pedro Llorente Flores on 23/9/21.
//

import SwiftUI

struct QuizPlayView: View{
    
    var quizItemIndex: Int
    
    @EnvironmentObject var quizzesModel: QuizzesModel
    @State var answer: String = ""
    @State var showAlert = false
    @State var angle = 0.0
    @State var pos = 0
    
    
   
    @EnvironmentObject var scoresModel: ScoresModel
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View{
        let aurl = quizItem.attachment?.url
        let anivm = NetworkImageViewModel(url: aurl)
        
        let uurl = quizItem.author?.photo?.url
        let univm = NetworkImageViewModel(url: uurl)
        
        if verticalSizeClass != .compact {
            VStack{
                HStack{
                    Text(quizItem.question)
                        .font(.headline)
                    
                    Button(action: {
                        quizzesModel.toggleFavorito(quizItem: quizItem)
                        withAnimation (.easeInOut(duration: 1)){
                        angle += 180
                
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now()+1){
                            withAnimation (.easeInOut(duration: 1)){
                            angle += 180
                    
                            }
                        }
                    }, label:{
                            Image(quizItem.favourite ? "star_yellow" : "star_grey")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .scaledToFit()
                        
                    }
                    )
                }
                TextField("Respuesta",
                          text: $answer,
                          onCommit: {
                    showAlert = true
                    scoresModel.check(respuesta : answer, quiz : quizItem)
                })
                    .alert(isPresented: $showAlert){
                    let s1 = quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    let s2 = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                   
                    return Alert(title: Text("Resultado"),
                              message: Text(s1 == s2 ? "ok" : "mal"),
                              dismissButton: .default(Text("ok")))
                    }
                    
                Button(action: {
                    showAlert = true
                    scoresModel.check(respuesta : answer, quiz : quizItem)
                })
                    {Text("Comprobar")}

                        NetworkImageView(viewModel: anivm)
                        .scaledToFit()
                       // .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 4))
                        .padding(30)
                        .saturation(self.showAlert ? 0.1 : 1)
                        .animation(.easeInOut, value: self.showAlert)
                        .rotationEffect(Angle(degrees: angle))
                        //.scaleEffect(scale)
                        .onTapGesture(count: 2) {
                            answer = quizItem.answer
                            withAnimation (.easeInOut(duration: 1)){
                            angle += 180
                    
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                                withAnimation (.easeInOut(duration: 1)){
                                answer = quizItem.answer
                                angle += 180
                        
                                }
                            }
                        }
                
                Text(quizItem.author?.username ?? "anónimo")
                    .font(.callout)
                    .foregroundColor(.green)
                NetworkImageView(viewModel: univm)
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 4))
                    .contextMenu{
                        Button(action: {
                            answer = ""
                        }){
                            Text("Borrar todo🗑🗑🗑")
                        }
                        Button(action: {
                            answer = quizItem.answer
                        }){
                            Text("La respuestica porfa🎀💵")
                        }
                        }
                Text("puntos : \(scoresModel.acertadas.count)")
                       
                }
            
    }else{
    HStack{
        VStack{
    title
    TextField("Respuesta",
              text: $answer,
              onCommit: {
        showAlert = true
        scoresModel.check(respuesta : answer, quiz : quizItem)
    })
        .alert(isPresented: $showAlert){
        let s1 = quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        let s2 = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
       
        return Alert(title: Text("Resultado"),
                  message: Text(s1 == s2 ? "ok" : "mal"),
                  dismissButton: .default(Text("ok")))
        }
    Button(action: {
        showAlert = true
        scoresModel.check(respuesta : answer, quiz : quizItem)
    })
        {Text("Comprobar")}
        Text(quizItem.author?.username ?? "anónimo")
            .font(.callout)
            .foregroundColor(.green)
        NetworkImageView(viewModel: univm)
            .scaledToFit()
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            .overlay(Circle().stroke(lineWidth: 4))
            .contextMenu{
                Button(action: {
                    answer = ""
                }){
                    Text("Borrar todo🗑🗑🗑")
                }
                Button(action: {
                    answer = quizItem.answer
                }){
                    Text("La respuestica porfa🎀💵")
                }
                }
    Text("puntos : \(scoresModel.acertadas.count)")
    }
    NetworkImageView(viewModel: anivm)
    .scaledToFit()
   // .frame(width: 100, height: 100)
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 4))
    .padding(30)
    .saturation(self.showAlert ? 0.1 : 1)
    .animation(.easeInOut, value: self.showAlert)
    .rotationEffect(Angle(degrees: angle))
    //.scaleEffect(scale)
    .onTapGesture(count: 2) {
        answer = quizItem.answer
        withAnimation (.easeInOut(duration: 1)){
        angle += 180
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            withAnimation (.easeInOut(duration: 1)){
            answer = quizItem.answer
            angle += 180
            }
        }
    }
}
   
    }
        
    }
    private var quizItem: QuizItem{
        
        quizzesModel.quizzes[quizItemIndex]
    }
    private var title : some View{
    HStack{
        Text(quizItem.question)
            .font(.headline)
        
        Button(action: {
            quizzesModel.toggleFavorito(quizItem: quizItem)
            withAnimation (.easeInOut(duration: 1)){
            angle += 180
    
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                withAnimation (.easeInOut(duration: 1)){
                angle += 180
        
                }
            }
        }, label:{
                Image(quizItem.favourite ? "star_yellow" : "star_grey")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
            
        }
        )
    }
}
   
}

