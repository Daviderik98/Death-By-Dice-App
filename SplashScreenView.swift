//
//  SplashScreenView.swift
//  diceNewGame
//
//  Created by David Persson on 2023-11-06.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    
    @State private var size = 0.8
    @State var opacity = 0.5
    var body: some View {
        if(isActive){
            ContentView()
        }
        else{
            ZStack{
                Color(.black).ignoresSafeArea()
                VStack{
                    GeometryReader{ geometry in
                        VStack{
                            Text("DEATH BY DICE").font(.headline).bold().foregroundColor(.white)
                            Image(systemName: "dice").font(.system(size:geometry.size.width/4)).foregroundColor(.pink).padding().background(.green).cornerRadius(20).position(x:geometry.size.width/2, y:geometry.size.height/2)
                            
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear{
                            withAnimation(.easeIn(duration: 1.5)){
                                self.size = 0.9
                                self.opacity = 1.0
                            }
                        }
                        
                    }
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        self.isActive = true
                    }
                }
            }
        }
    
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
