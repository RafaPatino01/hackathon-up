//
//  SearchView.swift
//  MovilityApp
//
//  Created by Marco Núñez on 29/04/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject var originObject = Origin()
    @StateObject var destinationObject = Destination()

    @State private var origin: String = "Ciudad de origen"
    @State private var originSlug: String = ""
    @State private var destination: String = "Ciudad de destino"
    @State private var destinationSlug: String = ""
    @State private var departureDate = Date()
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    Text("Búsqueda")
                        .font(.largeTitle)
                    VStack(alignment:.leading){
                        Text("Origen")
                        NavigationLink(destination: TerminalsView(sharedVariable:$origin, sharedSlug: $originSlug)){
                            Text(origin)
                                .multilineTextAlignment(.leading)
                                .padding([.top, .leading, .bottom], 8.0)
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .border(.tertiary)
                                .foregroundColor(origin != "Ciudad de origen" ? Color("OnPrimaryContainer") : Color("Placeholder"))
                                .cornerRadius(5)
                        }
                        Text("Destino")
                        NavigationLink(destination: TerminalsView(sharedVariable:$destination, sharedSlug: $destinationSlug).navigationTitle("").navigationBarTitleDisplayMode(.inline)){
                            Text(destination)
                                .multilineTextAlignment(.leading)
                                .padding([.top, .leading, .bottom], 8.0)
                                .frame(maxWidth:.infinity, alignment: .leading)
                                .border(.tertiary)
                                .foregroundColor(destination != "Ciudad de destino" ? Color("OnPrimaryContainer") : Color("Placeholder"))
                                .cornerRadius(5)
                        }
                        VStack(alignment:.leading){
                            DatePicker(
                                "Fecha de salida",
                                selection: $departureDate,
                                displayedComponents: [.date]
                                )
                        }
                        .datePickerStyle(.compact)
                        .padding()
                        NavigationLink(destination:BusesView(origin: $origin, destination: $destination ,originSlug: $originSlug, destinationSlug: $destinationSlug, departure: $departureDate ).navigationTitle("").navigationBarTitleDisplayMode(.inline)){
                                Text("Buscar")
                                    .foregroundColor(Color("OnPrimary"))
                                    .padding()
                                    .frame(maxWidth:.infinity)
                                    .cornerRadius(20)
                                    .background(Color("Primary"))
                                    .padding(.top)
                        }
                        Spacer()
                        
                    }
                    .padding()
                    .textFieldStyle(.roundedBorder)
                }
                .padding(.top)
                
            }
            }
            
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

func getBuses(){
    //call to API
    return
}
