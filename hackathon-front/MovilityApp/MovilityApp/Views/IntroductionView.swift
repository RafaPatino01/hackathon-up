//
//  IntroductionView.swift
//  MovilityApp
//
//  Created by Marco Núñez on 29/04/23.
//

import SwiftUI


struct IntroductionView: View {
    @State var isActive : Bool = false
    
    var body: some View {
        if isActive{
            LoginView()
        }
        else{
            ZStack{
                VStack{
                    Image("Bus")
                    VStack(spacing:20){
                        Text("ComparaBus")
                            .font(.largeTitle)
                        Text("Una sola app para tus viajes en autobús")
                    }
                    .padding()
                }
                
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
        
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IntroductionView()
            IntroductionView()
        }
    }
}
