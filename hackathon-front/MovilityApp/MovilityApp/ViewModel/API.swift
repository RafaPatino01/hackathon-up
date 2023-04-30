//
//  API.swift
//  MovilityApp
//
//  Created by Marco Núñez on 30/04/23.
//

import Foundation

func isLoginSuccessful(username: String, password: String, completion:@escaping ([String]) -> ()) {
    guard let url = URL(string: "http://122.8.178.68:3000/login?user_name="+username+"&password="+password) else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let result = try! JSONDecoder().decode([String].self, from: data!)
            print(result)
            DispatchQueue.main.async {
                completion(result)
        }
    }.resume()
}

func isRegisterSuccessful(username: String, password: String, completion:@escaping ([String]) -> ()) {
    guard let url = URL(string: "http://122.8.178.68:3000/add_user?user_name="+username+"&password="+password) else {
        print("Invalid url...")
        return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
        let result = try! JSONDecoder().decode([String].self, from: data!)
        print(result)
        DispatchQueue.main.async {
            completion(result)
        }
    }.resume()
}

struct Terminal: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var slug: String
    var isGroup: Int64
    var rankingOrigin: Int64
    var rankingDestination: Int64
}

func getTerminals(completion:@escaping ([Terminal]) -> ()){
    guard let url = URL(string: "http://122.8.178.68:3000/get_terminales") else {
        print("Invalid url...")
        return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
        let result = try! JSONDecoder().decode([Terminal].self, from: data!)
        DispatchQueue.main.async {
            completion(result)
        }
    }.resume()
}


struct Bus: Hashable, Codable, Identifiable{
    var id: Int64
    var company : String
    var hour : String
    var bus_stations: String
    var duration: String
    var price : String
}

func getBuses(originSlug: String, destinationSlug: String, departureDate : Date, completion:@escaping ([Bus]) -> ()){
    print(departureDate)
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    let dateString = dateFormatter.string(from: departureDate)
    let link = "https://www.clickbus.com.mx/es/buscar/\(originSlug)/\(destinationSlug)/?ida=\(dateString)"
    guard let url = URL(string: "http://122.8.178.68:3000/scraper?link=" + link) else {
        print("Invalid url...")
        return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
        let result = try! JSONDecoder().decode([Bus].self, from: data!)
        DispatchQueue.main.async {
            completion(result)
        }
    }.resume()
}


