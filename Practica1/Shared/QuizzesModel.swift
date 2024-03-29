//
//  QuizzesModel.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 17/09/2021.
//

import Foundation

class QuizzesModel: ObservableObject {
    
    // Los datos
    @Published private(set)var quizzes = [QuizItem]()
    @Published private(set) var acert = [QuizItem]()
    
    
    let TOKEN = "4d4e01d95b8d3480d66a"
    let URL_BASE = "https://core.dit.upm.es/api"
    
    
    init(){
        download()
    }
    
    func load() {
                
        guard let jsonURL = Bundle.main.url(forResource: "p1_quizzes", withExtension: "json") else {
            print("Internal error: No encuentro p1_quizzes.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            
//            if let str = String(data: data, encoding: String.Encoding.utf8) {
//                print("Quizzes ==>", str)
//            }
            
            let quizzes = try decoder.decode([QuizItem].self, from: data)
            
            self.quizzes = quizzes
            self.acert = quizzes

            print("Quizzes cargados")
        } catch {
            print("Algo chungo ha pasado: \(error)")
        }
    }
    func download(){
        let urlString = "\(URL_BASE)/quizzes/random10wa?token=\(TOKEN)"
        guard let url = URL(string: urlString) else{
            print("Error se ha matao")
            return
        }
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            
            
            if error == nil,
               (response as! HTTPURLResponse).statusCode == 200,
               let data = data {
                
                do{
                     let quizzes =  try JSONDecoder().decode([QuizItem].self, from: data)
                    DispatchQueue.main.async {
                        self.quizzes = quizzes
                    }
                    
                } catch {
                    print("Error4 las cagao decodificando")
                }
                } else{
                    print("Error3 las cagao decodificando", (response as! HTTPURLResponse).statusCode)
                }
            }
                
        .resume()
    }
    func toggleFavorito(quizItem: QuizItem){
        
        guard let index = quizzes.firstIndex(where: {qi in
            qi.id == quizItem.id
        })else{
            print("Error 1: url mal")
            return
        }
        
        let urlString = "\(URL_BASE)/users/tokenOwner/favourites/\(quizItem.id)?token=\(TOKEN)"
        guard let url = URL(string: urlString) else{
            print("Error se ha matao")
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = quizItem.favourite ? "DELETE" : "PUT"
        req.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        
        URLSession.shared.uploadTask(with: req, from: Data()){_, res, error in
            if error == nil,
               (res as! HTTPURLResponse).statusCode == 200{
                
                DispatchQueue.main.async {
                    self.quizzes[index].favourite.toggle()
                }
                
            }else{
                print("Favoritos errorrr")
            }
            
        }
        .resume()
    }
}
