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
   
    func playerDeletion(at offsets: IndexSet){
        let playerMass = dataControl.retrieveAllUsers()
        for offset in offsets{
            let playerX = playerMass[offset]
            dataControl.toDeletePlayer(activeplayer: playerX)
        }
    }
    
    var body: some View{
        List{
            ForEach(dataControl.retrieveAllUsers()){playerOne in
                VStack{
                    HStack{
                        Text(playerOne.userName ?? "Empty")
                        Text(playerOne.passWord ?? "Empty")
                    }
                    
                }
            }.onDelete(perform: playerDeletion)
        }
                    
                }
                
           }

struct ShowPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        ShowplayersView()
    }
}
