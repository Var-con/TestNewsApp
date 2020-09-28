//
//  NewsModel.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 27.09.2020.
//

import Foundation

struct MainNews: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let urlToImage: String?
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case urlToImage, content
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
