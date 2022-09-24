//
//  MovieModel.swift
//  Movie List
//
//  Created by MacBook Pro on 22/9/22.
//

import Foundation
import SwiftUI

struct MovieModel: Decodable {
    let results: [Movie]?
}

struct Movie: Decodable, Identifiable {
    let id: Int
    let original_title: String
    let overview: String
    let poster_path: String
}
