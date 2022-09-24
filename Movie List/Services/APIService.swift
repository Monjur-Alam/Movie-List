//
//  APIService.swift
//  Movie List
//
//  Created by MacBook Pro on 24/9/22.
//

import Foundation
import Combine

enum APIService {
    static private var baseURL: String {
        get {
            return "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query="
        }
    }
    
    static func searchBy(title: String) -> AnyPublisher<[Movie], Error> {
        guard let titleForSearch = title.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else { fatalError("Cannot add %20 to search text") }
        let params = titleForSearch.appending(titleForSearch)
        var request = URLRequest(url: (URL(string: baseURL + params))!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.send(request: request)
            .decode(type: MovieModel.self, decoder: JSONDecoder())
            .tryMap {
                guard let movies = $0.results else { throw RequestError.cannotParse }
                return movies
            }
            .eraseToAnyPublisher()
    }
}
