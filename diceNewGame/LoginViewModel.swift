//
//  LoginViewModel.swift
//  diceNewGame
//
//  Created by David Persson on 2023-11-06.
//

import Foundation
import CoreData

class LoginViewModel: ObservableObject{
    @Published var usersName: String = ""
    @Published var usersPass: String = ""
    @Published var errorMessage: String = ""
    @Published var currentPlayer: Player?
    let data_Controller = DataController()
    
    
    
   // func addOnePlayer(nameOne: String, nameTwo: String, viewCOntext: NSManagedObjectContext){
     //   dataController.addPlayer(enterName: nameOne, enterPass: nameTwo, context: viewCOntext)
   // }
    
    init(){}
    

    
    
    
    func findRightPlayerPrint(firstTxt: String, secondTxt: String, controller: DataController) -> String{
        var welcomingFull: String = ""
        let arrayPlayer: [Player] = controller.retrieveAllUsers()
        for playerIn in arrayPlayer{
            if(playerIn.userName == firstTxt && playerIn.passWord == secondTxt){
                print("We have found the right player")
               let welcomingOne = "Welcome "
                let welcomingTwo = playerIn.userName!
                welcomingFull = welcomingOne + welcomingTwo
                print(welcomingFull)
                self.currentPlayer = playerIn
                break
            }else{
                
                welcomingFull = "User cannot be found. You must have typed incorrectly"
            }
            
        }
        return welcomingFull
    }
    
    
    
  //  func loginPlayer(playerFirst: Player) -> Player{
        
    //    currentPlayer.self = playerFirst
        
   // }
    
}
