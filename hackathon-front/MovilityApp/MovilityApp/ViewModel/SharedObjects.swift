//
//  SharedObjects.swift
//  MovilityApp
//
//  Created by Marco Núñez on 30/04/23.
//

import Foundation

class Origin: ObservableObject {
    @Published var sharedVariable: String = "Ciudad de origen"
}

class Destination: ObservableObject{
    @Published var sharedVariable: String = "Ciudad de destino"
}
