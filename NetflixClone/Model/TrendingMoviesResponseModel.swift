//
//  TrendingMoviesResponseModel.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 8.05.2023.
//

import Foundation

struct TrendingMoviesResponse: Codable {
    let results: [MovieModel]
}
