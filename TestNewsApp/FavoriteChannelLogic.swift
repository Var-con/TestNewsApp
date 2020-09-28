//
//  FavoriteChannelLogic.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 28.09.2020.
//

import Foundation

class FavoriteChannelManager {
    
    static let shared = FavoriteChannelManager()
    
    init() {}
    
    
    func takeNewFavoriteChannel(with articleName: String) {
        UserDefaults.standard.setValue(articleName, forKey: articleName)
    }
    
    func checkFavoriteChannel(with articleName: String) -> Bool {
        var favorite = false
        guard let string = UserDefaults.standard.string(forKey: articleName) else { return false }
        print(string, articleName)
//        guard let array = (UserDefaults.standard.array(forKey: favoriteKey) ?? []) as? [String] else { return false}
            if string == articleName {
                favorite = true
            }
        
        return favorite
    }
    
    
    func deleteFromFavorite(with articleName: String) {
        UserDefaults.standard.removeObject(forKey: articleName)
    }
    
    
}
