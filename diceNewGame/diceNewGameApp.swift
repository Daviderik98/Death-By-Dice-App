//
//  diceNewGameApp.swift
//  diceNewGame
//
//  Created by David Persson on 2023-10-04.
//

import SwiftUI

@main
struct diceNewGameApp: App {
    @StateObject private var dataController = DataController()
    @StateObject private var logInModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            SplashScreenView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(DataController())
                .environmentObject(LoginViewModel())
        }
    }
}
