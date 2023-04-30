//
//  LoginView.swift
//  MovilityApp
//
//  Created by Marco Núñez on 29/04/23.
//

import SwiftUI
import Foundation

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State var success: Bool = false
    var body: some View {
        if (success == true){
            SearchView()
        }
        else{
            ZStack{
                NavigationView{
                    VStack{
                    Text("Bienvenido")
                        .font(.largeTitle)
                        .padding()
                    Text("Inicia sesión con tu cuenta")
                    VStack(alignment: .leading){
                        Text("Usuario")
                            .multilineTextAlignment(.leading)
                        TextField("Ingresa tu usuario",text: $username)
                            .autocapitalization(.none)
                        Text("Contraseña")
                            .multilineTextAlignment(.leading)
                        SecureField("Ingresa tu contraseña",text: $password)
                    }
                    
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    Button(action:{
                        isLoginSuccessful(username: username, password: password, completion: { (res) in
                            if(res[0] == "OK"){
                                success = true
                            }
                            else {
                                success = false
                            }
                        })}){
                            Text("Entrar")
                                .foregroundColor(Color("OnPrimary"))
                                .padding()
                                .frame(maxWidth:.infinity)
                                .cornerRadius(20)
                                .background(Color("Primary"))
                                .padding()
                    }
                    HStack{
                        Text("¿No tienes cuenta?")
                            
                                NavigationLink(destination: RegisterView()){
                                    Text("Regístrate")
                                        .foregroundColor(Color("Secondary"))
                                }
                        }
                        Spacer()
                    
                    }
                
                }
            }
        }
        }
            
        
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
