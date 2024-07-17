//
//  Keystore.swift
//  expenses
//
//  Created by pavel on 16/07/2024.
//

import Foundation

class Keystore {
    
    var API_URL: String! = nil
    var API_ACCESS_KEY: String! = nil
    
    init() {
        guard let path = Bundle.main.path(forResource: "Keystore", ofType: ".plist") else { return }
        guard let dictionary = NSDictionary(contentsOfFile: path) else { return }
        guard let API_URL = dictionary.object(forKey: "API_URL") as? String else { return }
        guard let API_ACCESS_KEY = dictionary.object(forKey: "API_ACCESS_KEY") as? String else { return }
        self.API_URL = API_URL
        self.API_ACCESS_KEY = API_ACCESS_KEY
    }
}
