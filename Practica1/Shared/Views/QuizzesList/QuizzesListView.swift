//
//  ContentView.swift
//  Shared
//
//  Created by Pedro Llorente Flores on 21/9/21.
//

import SwiftUI

struct QuizzesListView: View {
    
    @EnvironmentObject var quizzesModel: QuizzesModel
    @EnvironmentObject var scoresModel: ScoresModel
    @State var showPopover = false
    
    
    @State var verTodo: Bool = true
    
    var body: some View {
        Button(action: {
        self.showPopover = true
        }) { Text("CREADORES") }
        .popover(isPresented: $showPopover) {
        Text("Los creadores de esta aplicación son Pedro Llorente Flores y Elena del Junco Sampol, con el apoyo de Santiago Pavón")
        }
        NavigationView{
            List{
                Toggle("Ver todo", isOn: $verTodo )
                ForEach(quizzesModel.quizzes.indices, id: \.self) { index in
                     
                    if verTodo || !scoresModel.acertada(quizzesModel.quizzes[index]){
                    NavigationLink(destination: QuizPlayView(quizItemIndex: index)){
                        QuizRowView(quizItem: quizzesModel.quizzes[index])
                        //quizzesModel.acert(qi).remove
                    }
                    }
                    
                    
                    }
            }
        .padding()
        .navigationBarTitle(Text("Quiz SwiftUI"))
        .navigationBarItems(leading: Text("Record: ")
                                .font(.footnote)
                                
        +
                            Text("\(scoresModel.record.count)"),
                            trailing:
                                Button(action:{
            quizzesModel.download()
            scoresModel.limpiar()
        }){
               Label("Reload", systemImage: "arrow.triangle.2.circlepath")
            })
            
        .navigationBarItems(leading: ProgressView("\(Int(quizzesModel.quizzes.count-scoresModel.acertadas.count)) quizzes restantes", value: Float(scoresModel.acertadas.count), total: Float(quizzesModel.quizzes.count))
                                .contextMenu{
                                     Text("Total de Quizzes: \(quizzesModel.quizzes.count)")
        }
        )
                                
        
        .animation(.easeOut, value: 7)
    }
        
    }
  
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzesListView()
    }
}
*/
