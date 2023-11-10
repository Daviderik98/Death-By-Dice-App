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
    
    var body: some View{
        let playerActive = loginModel.currentPlayer
        let playerName = playerActive?.userName
        let playerPass = playerActive?.passWord
        let welcomingText: String = "Welcome \(playerName) with password \(playerPass)"
        VStack{
            Text(welcomingText)
            let challengeCollection = controller.retrieveChallengesByPlayer(player: playerActive!)
            List{
                ForEach(challengeCollection){challengeOne in
                    Text(challengeOne.challengeDescription ?? "Unknown")
                }
            }
        }
   }
}

struct PlayerStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerStatsView()
    }
}
