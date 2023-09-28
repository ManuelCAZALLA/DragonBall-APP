//
//  LocalData.swift
//  DragonBall-APP
//
//  Created by Manuel Cazalla Colmenero on 27/9/23.
//

import Foundation

struct LocalData {
    private static let key = "DragonBallToken"
    
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String?{
        userDefaults.string(forKey: key)
    }
    static func save(token: String) {
        userDefaults.set(token, forKey: key)
    }
    static func deleteToken(){
        userDefaults.removeObject(forKey: key)
    }
}
