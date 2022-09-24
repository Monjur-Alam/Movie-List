//
//  SearchMovieBar.swift
//  Movie List
//
//  Created by MacBook Pro on 24/9/22.
//

import SwiftUI

struct SearchMovieBar: View {
    @Binding var title: String
    
    var body: some View {
        HStack {
            TextField("Type a movie name...", text: $title)
                .padding([.leading, .trailing], 8)
                .frame(height: 32)
                .background(Color.gray.opacity(0.3))
            .cornerRadius(8)
        }
        .padding([.leading, .trailing], 16)
    }
}

struct SearchMovieBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovieBar(title: .constant(""))
            .previewLayout(.fixed(width: 300, height: 60))
    }
}

