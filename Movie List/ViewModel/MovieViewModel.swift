//
//  MovieViewModel.swift
//  Movie List
//
//  Created by MacBook Pro on 22/9/22.
//

import SwiftUI
import Combine

class MovieViewModel: ObservableObject {
    @Published var searchText = ""
    @Published private (set) var movies = [Movie]()
    
    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    deinit {
        searchCancellable?.cancel()
    }
    
    init() {
        searchCancellable = $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty && $0.first != " " }
            .flatMap { (searchString) -> AnyPublisher<[Movie], Never> in
                return APIService.searchBy(title: searchString)
                    .replaceError(with: []) //TODO: Handle Errors
                    .eraseToAnyPublisher()
            }
            .map {
                self.movieDisplayData(movies: $0)
            }
            .replaceError(with: []) //TODO: Handle Errors
            .assign(to: \.movies, on: self)
    }
    
    private func movieDisplayData(movies: [Movie]) -> [Movie]  {
        var displayDataItems = [Movie]()
        
        movies.forEach {
            let displayData = Movie(id: $0.id, original_title: $0.original_title, overview: $0.overview, poster_path: $0.poster_path)
            displayDataItems.append(displayData)
        }
        return displayDataItems
    }
    
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
