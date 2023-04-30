//
//  SearchView.swift
//  MovilityApp
//
//  Created by Marco Núñez on 29/04/23.
//

import SwiftUI

struct SearchView: View {
    @State private var origin: String = ""
    @State private var destination: String = ""
    @State private var departureDate = Date()
    @State private var returnDate = Date()
    var body: some View {
        ZStack{
            VStack{
                Text("Búsqueda")
                    .font(.largeTitle)
                VStack(alignment:.leading){
                    Text("Origen")
                    TextField("Ciudad de Origen",text: $origin)
                    Text("Destino")
                    TextField("Ciudad de Destino",text: $destination)
                    VStack(alignment:.leading){
                        DatePicker(
                            "Fecha de salida",
                            selection: $departureDate,
                            displayedComponents: [.date]
                            )
                        DatePicker(
                            "Fecha de llegada", selection: $returnDate,
                                displayedComponents: [.date]
                            )
                    }
                    .datePickerStyle(.compact)
                    Button(action:{getBuses()}){
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



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

func getBuses(){
    //call to API
    return
}
