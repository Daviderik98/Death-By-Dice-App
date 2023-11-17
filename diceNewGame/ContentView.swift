//
//  ContentView.swift
//  diceNewGame
//
//  Created by David Persson on 2023-10-04.
//

import SwiftUI
import CoreData


//(time of writing : 2023-10-29 13.35) TODO - Build new Content View with Login Screen. Implement Core Data into the Application. Make Navigation work for all views. Add Alerts to what the Player cannot do


struct ContentView: View{
    
   // @Environment(\.managedObjectContext) var moc
  //  @FetchRequest(sortDescriptors: []) var allPlayers: FetchedResults<Player>
    
    @State var enterName: String = ""
    @State var enterPass: String = ""
    @State var welcomeTxt: String = ""
    @State var message = ""
   // func specificPlayer(nameOne: String, nameTwo: String){
    //}
    
    
    @EnvironmentObject var loginModel : LoginViewModel
    @EnvironmentObject var dataController: DataController
    
    var body: some View{
        NavigationView{
            GeometryReader{ geometry in
                ZStack{
                Color(CGColor(red: 30/255, green: 79/255, blue: 85/255, alpha: 1)).ignoresSafeArea() //Just wanted to save this color
              //  Color(CGColor(red: 60/255, green: 70/255, blue: 100/255, alpha: 1)).ignoresSafeArea()
                
                    
                        //Main Headline
                        Image(systemName: "dice")
                            .imageScale(.large)
                            .foregroundColor(.red).position(x:geometry.size.width/2, y:geometry.size.height/11)
                        Text("Death by Dice: The Game").position(x:geometry.size.width / 2, y:geometry.size.height / 30).font(.title).bold().foregroundColor(.brown)
                    
                    Text("Welcome to Death By Dice. All you have to do to start playing is sign in to your account").position(x:geometry.size.width/3,y:geometry.size.height/5).font(.title3).fontWeight(.medium).foregroundColor(.white).frame(width:geometry.size.width*0.7)
                        
                 
                    VStack{
                      //  if let message = loginModel.errorMessage{
                            Text(message).foregroundColor(.red)
                      //  }
                            
                        TextField("username", text: $enterName).frame(width:geometry.size.width/1.5, height:geometry.size.height/20).background(.white)
                        SecureField("password", text: $enterPass).frame(width:geometry.size.width/1.5, height:geometry.size.height/20).background(.white).padding()
                        Text(welcomeTxt).foregroundColor(.orange)
                        
                        
                        HStack{
                            Button( action:{
                                if(enterName != "" && enterPass != ""){
                                    welcomeTxt = loginModel.findRightPlayerPrint(firstTxt: enterName, secondTxt: enterPass, controller: dataController)
                                }
                                else{
                                    message = "Make sure you have filled in all fields"
                                }
                                //Insert more code : Search CoreData for Player with matching password, then log in
                            }, label: {
                                Text("Enter name").frame(width:geometry.size.width/4, height:geometry.size.height/20).foregroundColor(.blue).background(.green).cornerRadius(5).padding()
                            })
                        if(welcomeTxt != "" && welcomeTxt != "User cannot be found. You must have typed incorrectly"){
                                NavigationLink(destination: DicerollView(), label: {
                                    Text("Start Game").frame(width:geometry.size.width/3, height:geometry.size.height/20).background(.green).cornerRadius(5).padding()
                                })
                            }
                            
                        }
                        NavigationLink(destination: AccountView(), label: {Text("No account? Click here").frame(width:geometry.size.width/3, height:geometry.size.height/15).background(.yellow).cornerRadius(6)})
                    
                        
                        
                    } //VStack 2nd Opening ContentView
               
                    //The NavigationLink below is not part of the app, I only used it to make sure that Core Data saved Players correctly
                   // NavigationLink(destination: ShowplayersView(), label: {Text("Show alla ccounts")}).position(x:geometry.size.width/2, y:geometry.size.height*0.8).font(.headline).foregroundColor(.cyan)
            } //ZStack Opening COntentView
            } //GeometryReader ContentView
            
        }.navigationTitle("Home Page") //NavigationView ContentView
    }
}


    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            //AccountView()
            //ShowPlayersView()
            //DicerollView()
           // ChallengeView()
            
            
        }
    }
    

