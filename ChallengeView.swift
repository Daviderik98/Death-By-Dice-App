//
//  ChallengeView.swift
//  diceNewGame
//
//  Created by David Persson on 2023-11-08.
//

import SwiftUI

var challengerOne: String = ""
var categoryOne: String = ""

struct ChallengeView: View{
    //Update 19/10: this part works well. Now to style this part a lot more
    @EnvironmentObject var dataControl: DataController
    @EnvironmentObject var loggInModel: LoginViewModel
    
    //  @Environment(\.managedObjectContext) var moc_Ch
    //  @FetchRequest(entity: Player.entity(), sortDescriptors: []) var allPlayers: FetchedResults<Player>
    @Binding var challenger: String
    @Binding var selectedCategory: Int
    
    enum acceptance {
        case onAccept
        case offAccept
    }
    @State var toAccept = acceptance.offAccept
    
    @State var onDecline: Bool = false
    
    @State var presentCh: Bool = false
    @State var denyOnce: Int = 0
    @State var showChallenge: String = ""
    @State var highAlert: String = "You can no longer decline from more challenges"
    
    let SelectChallenges = ChallengePicker()
    @State var generator: Int = Int.random(in: 0...2)
    
    func turnChallengeOn(){
        switch(selectedCategory){
        case 1:
            showChallenge = SelectChallenges.chRoutines[generator]
        case 2:
            showChallenge = SelectChallenges.chHonesty[generator]
        case 3:
            showChallenge = SelectChallenges.chWorkout[generator]
        case 4:
            showChallenge = SelectChallenges.chStayhealthy[generator]
        case 5:
            showChallenge = SelectChallenges.chEcofriendly[generator]
        case 6:
            showChallenge = SelectChallenges.chRandom[generator]
        default:
            showChallenge = "Error. There is no challenge for you right now"
        }
    }
    var body: some View{
        //TODO - Place varialbe generator here instead of inside switch
        
        let activePlayer = loggInModel.currentPlayer
        let activeName = activePlayer?.userName
        
        GeometryReader{ geometry in
            ZStack{
                Color(CGColor(red: 19/255, green: 58/255, blue: 125/255, alpha: 1)).ignoresSafeArea()
                // From DicerollView, possible for change red: 9/255, green: 58/255, blue: 25/255, alpha: 1
                HStack{
                    Text("Current Player : ")
                    Text(activeName ?? "Bland")
                }.position(x:geometry.size.width/2, y:geometry.size.height/6)
                
                Text("Your Chosen Category : \(challenger) ").font(.headline).fontWidth(.expanded).frame(width:geometry.size.width*0.9).position(x:geometry.size.width/2, y:geometry.size.height/3)
                if(presentCh != true){
                    Button(action: {
                        presentCh.toggle()
                        turnChallengeOn()
                    }, label: {Text("Ready for your challenge? Click here")})
                }
                else{
                    
                    Text(showChallenge).bold().foregroundColor(.orange).frame(width:geometry.size.width*0.8)
                        
                            Button(action: {
                                if(toAccept == acceptance.offAccept){
                                    dataControl.addChallenge(thisText: showChallenge, thisPlayer: activePlayer!)
                                    toAccept = acceptance.onAccept
                                }
                                else{
                                    highAlert = "You can only accept one challenge at a time"
                                }
                            }, label: {
                                Text("Accept")
                            }).bold().foregroundColor(.green).padding().background(.white).cornerRadius(6).position(x:geometry.size.width/3, y:geometry.size.height*0.6)
                            Button(action: {
                                if(toAccept == acceptance.onAccept){
                                    highAlert = "You cannot decline, because you have already accepted one challenge"
                                }
                                else{
                                    
                                    denyOnce += 1
                                    if(denyOnce > 2){
                                        onDecline.toggle()
                                    }
                                    else{
                                        generator = Int.random(in: 0...2 )
                                        turnChallengeOn()
                                    }
                                }
                            }, label: {Text("Decline")}).bold().foregroundColor(.red).padding().background(.white).cornerRadius(6).position(x:geometry.size.width*0.7, y: geometry.size.height*0.6)
                        
                    
                }
              
            
                //Hstack Buttons
                NavigationLink(destination: PlayerStatsView(), label: {Text("Click here to view all your challenges")}).position(x:geometry.size.width/2, y:geometry.size.height*0.8)
                //VStack ChallengeView
            } //ZStack ChallengeView
        }
        .alert(Text(highAlert), isPresented: $onDecline, actions: {}) //Geometry Reader ChallengeView
        
        
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        DicerollView()
       // ChallengeView()
    }
}
