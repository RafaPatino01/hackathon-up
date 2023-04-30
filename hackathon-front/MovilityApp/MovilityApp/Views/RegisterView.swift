//
//  RegisterView.swift
//  MovilityApp
//
//  Created by Marco Núñez on 29/04/23.
//

import SwiftUI
import Foundation

struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State var success: Bool = false
    var body: some View {
        if(success == true){
            SearchView()
        }
        else{
            ZStack{
                VStack(spacing:25){
                    Text("Regístrate")
                        .font(.largeTitle)
                        .padding()
                        .multilineTextAlignment(.center)
                    Text("Viaja en autobús sin complicaciones")

                    VStack(alignment: .leading){
                        Text("Usuario")
                            .multilineTextAlignment(.leading)
                        TextField("Ingresa tu usuario",text: $username)
                            .autocapitalization(.none)
                        Text("Contraseña")
                            .multilineTextAlignment(.leading)
                        SecureField("Ingresa tu contraseña",text: $password)
                        Button(action:{
                            isRegisterSuccessful(username: username, password: password, completion: { (res) in
                                if(res[0] == "OK"){
                                    success = true
                                }
                                else {
                                    success = false
                                }
                            })
                        }){
                                Text("Registrarse")
                                    .foregroundColor(Color("OnPrimary"))
                                    .padding()
                                    .frame(maxWidth:.infinity )
                                    .cornerRadius(20)
                                    .background(Color("Primary"))
                                    .padding()
                        }
                    }
                    .padding()
                    .textFieldStyle(.roundedBorder)
                        
                    HStack(spacing:15){
                        Text("O regístrate usando")
                        Image("Google")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 30,height: 30)
                            .scaledToFit()
                        Image("Facebook")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 30,height: 30)
                            .scaledToFit()
                    }

                    
                    
                    
                    Spacer()
                }
                
            }
        }
        }
        
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

