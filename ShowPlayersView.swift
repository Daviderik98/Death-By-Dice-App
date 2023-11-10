//
//  ShowPlayersView.swift
//  diceNewGame
//
//  Created by David Persson on 2023-11-08.
//

import SwiftUI

struct ShowplayersView: View{
    
    //@Environment(\.managedObjectContext) var managedContext
    
    @EnvironmentObject var dataControl: DataController
    
    
    
    var body: some View{
        let allPlayers: [Player] = dataControl.retrieveAllUsers()
                 // Text("AWAITING DB FOR ALL USERS")
        List{
            ForEach(allPlayers){playerOne in
                VStack{
                    HStack{
                        Text(playerOne.userName ?? "Empty")
                        Text(playerOne.passWord ?? "Empty")
                    }
                    
                }
            }
        }
                    
                }
                
           }

struct ShowPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        ShowplayersView()
    }
}
