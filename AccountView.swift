//
//  AccountView.swift
//  diceNewGame
//
//  Created by David Persson on 2023-11-08.
//

import SwiftUI

struct AccountView: View{
    
    @Environment(\.managedObjectContext) var moc
    //@FetchRequest(sortDescriptors: []) var allPlayers: FetchedResults<Player>
    
    @State var accountName: String = ""
    @State var accountPass: String = ""
    @State var welcome_txt: String = ""
    
    @State var accountCreated = false
    
    @EnvironmentObject var dataControl: DataController
    @EnvironmentObject var loginModel: LoginViewModel
    
    var body: some View{
            ZStack{
                Color(CGColor(red: 50/255, green: 110/255, blue: 50/255, alpha: 1)).ignoresSafeArea()
                GeometryReader{ geometry in
                    
                        Text("Welcome new Player! Here is where you create your new account. Just fill in the fields and hit Save").font(.title2).frame(width:geometry.size.width*0.8).position(x:geometry.size.width/2, y:geometry.size.height/5)
                    TextField("Username", text: $accountName).frame(width:geometry.size.width * 0.8, height: geometry.size.height/25).background(.white).position(x:geometry.size.width/2, y:geometry.size.height/2.5)
                    TextField("Password", text: $accountPass).frame(width:geometry.size.width * 0.8, height: geometry.size.height/25).background(.white).position(x:geometry.size.width/2, y:geometry.size.height/2)
                    
                    Text(welcome_txt).foregroundColor(.pink)
                        
                        Button(action: {
                            let newPlayer = dataControl.addPlayer(enterName:accountName, enterPass: accountPass)
                        welcome_txt = loginModel.findRightPlayerPrint(firstTxt: newPlayer.userName ?? "Bland", secondTxt: newPlayer.passWord ?? "example", controller: dataControl)
                            accountCreated = true
                        }, label: {
                            Text("Enter your data -->").padding().background(.black).cornerRadius(5)
                            
                        }).position(x:geometry.size.width/2, y:geometry.size.height*0.68)
                        if(accountCreated == true){
                            let loggedInPlayer =
                           
                            NavigationLink(destination: DicerollView(), label: {Text("Start Playing")}).position(x:geometry.size.width/2, y:geometry.size.height*0.8)
                    }
                    
                    
                } //GeometryReader AccountView
            }

    }
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
