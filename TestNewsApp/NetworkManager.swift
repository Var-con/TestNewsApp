//
//  NetworkManager.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 27.09.2020.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    init() {}
    
    func fetchNews(from url: String, complitionHandler: @escaping (MainNews) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                let newsData = try decoder.decode(MainNews.self, from: data)
                complitionHandler(newsData)
            }
            catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
