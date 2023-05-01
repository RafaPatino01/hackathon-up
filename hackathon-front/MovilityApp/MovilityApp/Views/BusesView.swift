//
//  BusesView.swift
//  MovilityApp
//
//  Created by Marco Núñez on 30/04/23.
//

import SwiftUI

struct BusesView: View {
    @Binding var origin: String
    @Binding var destination: String
    @Binding var originSlug: String
    @Binding var destinationSlug: String
    @Binding var departure: Date
    @State var buses : [Bus] = []
    var body: some View {
        VStack(alignment:.leading){
            VStack(alignment:.leading){
                HStack(spacing:20){
                    Text("Salida: ")
                        .fontWeight(.bold)
                    Text(origin)
                }
                .padding()
                HStack(spacing:20){
                    Text("Llegada: ")
                        .fontWeight(.bold)
                    Text(destination)
                }
            }
            .padding()
            
            Spacer()
            List(buses) { bus in
                VStack(alignment:.leading){
                    HStack{
                        VStack(alignment:.leading){
                            HStack{
                                Text("Compañía: ")
                                    .fontWeight(.bold)
                                    
                                Text(bus.company)
                                    .font(.title2)
                            }
                            HStack{
                                Text("Duración: ")
                                    .fontWeight(.bold)
                                Text(bus.duration)
                            }
                            HStack{
                                Text("Precio: ")
                                    .fontWeight(.bold)
                                Text(bus.price)
                            }
                            
                            HStack{
                                Text("Horario: ")
                                    .fontWeight(.bold)
                                Text(bus.hour)
                            }
                            
                        }
                        VStack(alignment:.trailing){
                            Text("➡︎")
                                .padding()
                                .foregroundColor(Color("OnPrimary"))
                                .background(Color("Primary"))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top)
                    .padding(.bottom)
                    
                    
                    
                }
                HStack{
                    Text("")
                }
                .padding(.bottom,1.5)
                
            }
            .onAppear{
                getBuses(originSlug: originSlug, destinationSlug: destinationSlug, departureDate: departure) { (buses) in
                    self.buses = buses
                }
            }
        }
    }

}
