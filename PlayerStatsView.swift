//
//  PlayerStatsView.swift
//  diceNewGame
//
//  Created by David Persson on 2023-11-08.
//

import SwiftUI

struct PlayerStatsView: View{
    
    @EnvironmentObject var controller: DataController
    @EnvironmentObject var loginModel: LoginViewModel
    
    func toDeletion(at offsets: IndexSet){
        if let onePlayer = loginModel.currentPlayer {
            let allChallenges = controller.retrieveChallengesByPlayer(player: onePlayer)
            for offset in offsets{
                let challengeX = allChallenges[offset]
                controller.deleteOneChallenge(userChallengeOne: challengeX)
            }
        }
    }
    
    var body: some View{
        
        if let activePlayer = loginModel.currentPlayer {
            
            VStack{
                Text("Welcome \(activePlayer.userName ?? "No username") with password \(activePlayer.passWord ?? "No password")")

                List{
                    ForEach(controller.retrieveChallengesByPlayer(player: activePlayer)){challengeOne in
                        Text(challengeOne.challengeDescription ?? "Unknown")
                    }
                    .onDelete(perform: toDeletion)
                }
            }
        } else {
            Text("No active player")
        }
   

    }
    

   
}

struct PlayerStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerStatsView()
    }
}
