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
