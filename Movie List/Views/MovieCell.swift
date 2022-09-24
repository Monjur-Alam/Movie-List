//
//  MovieCell.swift
//  Movie List
//
//  Created by MacBook Pro on 22/9/22.
//

import SwiftUI

struct MovieCell: View {
    private let displayData: Movie
    
    init(displayData: Movie) {
        self.displayData = displayData
    }
    
    var body: some View {
        HStack() {
            
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(displayData.poster_path)")) { image in
                image.resizable()
            } placeholder: {
                ZStack {
                    Image("empty")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 80)
                    ProgressView()
                }
            }
            .frame(width: 60, height: 80)

            VStack(alignment: .leading) {
                Text(displayData.original_title)
                    .font(.title3)

                Text(displayData.overview)
                    .font(.subheadline)
                    .lineLimit(5)
            }
        }
    }
}

let movieDemoData = Movie(id: 1, original_title: "Demo Movie Data", overview: "Demo movie data show here. Demo movie data show here. Demo movie data show here.", poster_path: "Movie image")

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(displayData: movieDemoData)
            .previewLayout(.fixed(width: 300, height: 65))
            .previewDisplayName("SearchMovieCell")
    }
}
