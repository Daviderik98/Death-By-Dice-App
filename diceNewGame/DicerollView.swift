//
//  DicerollView.swift
//  diceNewGame
//
//  Created by David Persson on 2023-11-08.
//

import SwiftUI


struct DicerollView: View {
    
    // @Environment(\.managedObjectContext) var moc
    //  @FetchRequest(sortDescriptors: []) var allPlayers: FetchedResults<Player>
    
    @State var theDice: Int = 0
    @State var cateGory: String = "Roll Dice Again"
    
    @State var rollMore: Bool = false
    
    func rollTheDice() -> Void{
        theDice = Int.random(in: 1...6)
        switch(theDice){
        case 1:
            cateGory = "Daily routine"
        case 2:
            cateGory = "Honesty"
        case 3:
            cateGory = "Workout"
        case 4:
            cateGory = "Health"
        case 5:
            cateGory = "ECO-Awareness"
        case 6:
            cateGory = "Random"
        default:
            cateGory = "Roll Dice Again"
        }
    }
    
    func resetDice()-> Void{
        theDice = 0
        cateGory = "Roll Dice Again"
    }
    
    
    var body: some View {
        
        ZStack{
            Color(CGColor(red: 9/255, green: 58/255, blue: 25/255, alpha: 1)).ignoresSafeArea()
            GeometryReader{ geometry in
                VStack {
                    Image(systemName: "dice")
                        .imageScale(.large)
                        .foregroundColor(.red)
                    Text("Death by Dice: The Game").font(.title).bold().foregroundColor(.brown)
                    Text("Death by dice is a game in which you roll a dice and accept a challenge.  Your diceroll will determine the category of what challenge you get. Press the button below to roll your dice").font(.subheadline)
                    
                    Button(action: {
                        if(theDice > 0 && cateGory != "Roll Dice Again"){
                            //print("I think you have already rolled")
                            rollMore.toggle()
                        }
                        else{
                            rollTheDice()}
                        
                    }, label: {Text("Now to roll").font(.title2)
                    }).padding()
                    if(theDice == 0 || cateGory == "Roll Dice Again"){
                        Text("You have yet to roll your dice")
                    }
                    else{
                        Image("dice-\(theDice)"
                        )
                        Text("Double click on your category to get the challenge")
                    }
                    VStack{
                        
                        if(theDice <= 0){
                            Text("Insert Category here...").foregroundColor(.gray)
                        }
                        else{
                            NavigationLink(destination: ChallengeView(challenger: $cateGory, selectedCategory: $theDice), label: {Text("Category : \(cateGory)").padding().background(.black).foregroundColor(.cyan).cornerRadius(5)})
                        }
                        Button(action:{resetDice()}, label:{Text("Undo Dice Roll")}).padding()
                    } //VStack
                }.position(x:geometry.size.width/2, y:geometry.size.height/2) //FULL VSTACK
            }.alert(Text("You have already rolled once, and have to undo it before you roll again!"), isPresented: $rollMore, actions: {}) //GeometryReader
        } //ZStack
    }
}
    
    struct DicerollView_Previews: PreviewProvider {
        static var previews: some View {
            DicerollView()
        }
    }

