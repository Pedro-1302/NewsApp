//
//  NewsListRepository.swift
//  News
//
//  Created by Pedro Franco on 28/06/23.
//

import Foundation

enum NewsListError: Error {
    case fileNotFound
}

// Singleton
// Tem os dados do meu json
class NewsListRepository {
    
    // Uma instancia
    static var shared: NewsListRepository = {
        let instance = NewsListRepository()
        return instance
    }()
    
    // Garantindo que só tera uma instancia
    private init() {}
    
    // Faz a busca no arquivo e retorna uma lista do tipo NewsModel, senão retorna erro
    func getNewsList(completation: ([NewsModel]?, Error?) -> Void) -> Void {
        if let path = Bundle.main.path(forResource: "NewsList", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                
                // Converter a minha url pra um tipo de dado do tipo Data
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                
                // Os dados lidos serao decodificados para NewsModel
                let newsModelList = try decoder.decode([NewsModel].self, from: data)
                
                // Ou retorna o resultado da chamada ou erro
                completation(newsModelList, nil)
            } catch {
                // print("\(error)")
                // Se der erro ele pega e da erro
                completation(nil, error)
            }
        } else {
            completation(nil, NewsListError.fileNotFound)
        }
    }
}
