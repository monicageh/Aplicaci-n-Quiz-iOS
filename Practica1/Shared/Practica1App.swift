//
//  Practica1App.swift
//  Shared
//
//  Created by Pedro Llorente Flores on 21/9/21.
//

import SwiftUI

@main
struct Practica1App: App {
    let quizzesModel = QuizzesModel()
    let scoresModel = ScoresModel()
    
    
    var body: some Scene {
        WindowGroup {
            QuizzesListView()
                .environmentObject(quizzesModel)
                .environmentObject(scoresModel)
                
        }
    }
}
