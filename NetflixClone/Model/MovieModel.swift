//
//  MovieModel.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 8.05.2023.
//

import Foundation

struct MovieModel: Codable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String? 
    let overview: String?
    let voteCount: Int
    let releaseDate: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
