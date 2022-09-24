//
//  MovieViewModel.swift
//  Movie List
//
//  Created by MacBook Pro on 22/9/22.
//

import SwiftUI
import Combine

class MovieViewModel: ObservableObject {
    @Published private (set) var movies = [Movie]()
    
    func fachMovie() {
        if let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=Marvel") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let data = try decoder.decode(MovieModel.self, from: safeData)
                            DispatchQueue.main.async {
                                self.movies = data.results!
                            }
                        } catch {
                            print(error)
                        }

                    }
                }
            }
            task.resume()
        }
    }
}
