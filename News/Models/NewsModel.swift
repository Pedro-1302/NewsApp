//
//  NewsModel.swift
//  News
//
//  Created by Pedro Franco on 28/06/23.
//

import UIKit

// Codable = Muda o comportamento da struct para ela poder ser decodificada
// permite transformar meu json na struct ou a struct no json 
struct NewsModel: Codable {
    var source: SourceModel
    var autor: String?
    var tittle: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Date?
    var content: String?
}
