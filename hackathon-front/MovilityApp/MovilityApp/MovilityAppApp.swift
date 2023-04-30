//
//  MovilityAppApp.swift
//  MovilityApp
//
//  Created by Marco Núñez on 29/04/23.
//

import SwiftUI

@main
struct MovilityAppApp: App {
    var body: some Scene {
        WindowGroup {
            IntroductionView()
        }
    }
}

struct Previews_MovilityAppApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
