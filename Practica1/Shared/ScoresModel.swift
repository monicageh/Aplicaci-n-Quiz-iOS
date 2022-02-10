//
//  ScoresModel.swift
//  Practica1
//
//  Created by Pedro Llorente Flores on 23/9/21.
//

import Foundation

class ScoresModel: ObservableObject{
    @Published private(set) var acertadas: Set<Int> = []
    @Published private(set) var record: Set<Int> = []
   
    //@Published var contador: Float = 0.0
   
    init(){
        if let record = UserDefaults.standard.object(forKey: "record") as? [Int] {
            self.record = Set(record)
        }
    }
   
    
    func check(respuesta: String, quiz: QuizItem){
        let r1 = respuesta.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let r2 = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if r1 == r2 {
            acertadas.insert(quiz.id)
            record.insert(quiz.id)
            UserDefaults.standard
                .set(Array<Int>(record), forKey: "record")
        }
        
    }
    func acertada (_ quizItem: QuizItem) -> Bool{
        if acertadas.contains(quizItem.id){
        return true
        }else{
        return false
        }
}
    func limpiar(){
        acertadas = []
    }
    
}
