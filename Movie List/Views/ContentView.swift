//
//  ContentView.swift
//  Movie List
//
//  Created by MacBook Pro on 22/9/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var movieViewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(movieViewModel.movies) { item in
                    MovieCell(displayData: item)
                }
            }
            .navigationBarTitle("Movie List")
        }
        .onAppear {
            self.movieViewModel.fachMovie()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
