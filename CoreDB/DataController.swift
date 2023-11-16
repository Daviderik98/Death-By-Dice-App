//
//  DataController.swift
//  diceNewGame
//
//  Created by David Persson on 2023-10-31.
//

import Foundation
import CoreData

//TODO - R ll/most prints with Alerts

class DataController: ObservableObject{
    let container: NSPersistentContainer = NSPersistentContainer(name: "PlayerData")
    
    var viewContext : NSManagedObjectContext{
        return container.viewContext
    }
    
    
    init(){
        container.loadPersistentStores{
            description, error in
            if let error = error{
                print("Failed to load data correctly : \(error.localizedDescription)")
            }
        }
    }
    
    func toSaveData(){
        do{
            try viewContext.save()
            print("Data successfully saved")
        }
        catch{
            print("Failed to Save Data")
        }
    }
    
    func addPlayer(enterName: String, enterPass: String) -> Player{
        let newPlayer = Player(context: viewContext)
        newPlayer.playerID = UUID()
        newPlayer.userName = enterName
        newPlayer.passWord = enterPass

        toSaveData()
        
        return newPlayer
    }
    
    func checkOffChallenge(onePlayer: Player, oneChallenge: String){  //TODO - Upgrade to also store the completed challenge in array
        //onePlayer.challengeArray.append(_ newElement: oneChallenge) TODO LATER
        toSaveData()
    }
    
    func addChallenge(thisText: String, thisPlayer: Player){ //This method is meant to add a challenge to one player account
       
        let newChallenge = UserChallenge(context: viewContext)
        
        newChallenge.challengeDescription = thisText
        newChallenge.isCompleted = false
        
        newChallenge.relationship = thisPlayer
        
       
        toSaveData()
        
        
    }
    
    func retrieveAllUsers() -> [Player]{
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        
        do{
            let arrayOfPlayers = try viewContext.fetch(fetchRequest)
            return arrayOfPlayers
        }catch{
            print("Error loading all Players")
            return []
            
        }
    }
    
    
    
    func retrieveChallengesByPlayer(player: Player) -> [UserChallenge]{
        
        let fetchRequest: NSFetchRequest<UserChallenge> = UserChallenge.fetchRequest()
        
        let predicate = NSPredicate(format: "relationship == %@", player)
        
        fetchRequest.predicate = predicate
        
        do {
            
            let userChallenges = try viewContext.fetch(fetchRequest)
            
            return userChallenges
            
            
        } catch {
            return []
        }
        
    }
    
    func deleteOneChallenge(userChallengeOne: UserChallenge){
        viewContext.delete(userChallengeOne)
        print("Attempted to delete your One Challenge")
        toSaveData()
    }
    
    
    func deleteAllChallenges(player: Player){
        let userChallenges = retrieveChallengesByPlayer(player: player)
        
        for challenge in userChallenges{
            viewContext.delete(challenge)
        }
        do{
            try viewContext.save()
        }catch{
            print("Failed to Delete Challenges!!!")
        }
    }
   
    
    
    
    func toDeletePlayer(activeplayer: Player){
  
        deleteAllChallenges(player: activeplayer)
        
        viewContext.delete(activeplayer)
        
       do{
           try viewContext.save()
        }catch{
            print("Failed to Delete this Player! Contact your administrator for more help")
        }
    }
    
    
}
