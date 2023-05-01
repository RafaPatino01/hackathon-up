//
//  TerminalsView.swift
//  MovilityApp
//
//  Created by Marco Núñez on 30/04/23.
//

import SwiftUI

struct TerminalsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var sharedVariable: String
    @Binding var sharedSlug: String
    @State var terminals : [Terminal] = []
    @State private var searchText = ""
    var body: some View {
            VStack{
                NavigationView{
                    List(searchResults) { terminal in
                        //NavigationLink(destination: SearchView().hidden){
                            Text(terminal.name)
                                .onTapGesture{
                                    sharedVariable = terminal.name
                                    sharedSlug = terminal.slug
                                    presentationMode.wrappedValue.dismiss()
                                }
                        //}
                    }
                    .onAppear{
                        getTerminals { (terminals) in
                            self.terminals = terminals
                        }
                    }
                    .searchable(text: $searchText)
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true) // hides the "back" or previous view title button
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Regresar") {
                            presentationMode.wrappedValue.dismiss() // this changes in iOS15
                        }
                    }
                }
                Spacer()
                
            }
    }
    
    var searchResults: [Terminal] {
        if searchText.isEmpty{
            return terminals
        }
        else {
            return terminals.filter { $0.name.contains(searchText)
            }
        }
    }
}


