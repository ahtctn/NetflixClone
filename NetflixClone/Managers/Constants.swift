//
//  Constants.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 7.05.2023.
//

import Foundation

enum Constants {
    static let API_KEY: String = "4c3320637d3f0260500a8287780a9baf"
    static let baseURL: String = "https://api.themoviedb.org"
    
    //MARK: PATHS
    
    static let moviesURL: String = "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)"
    
    static let upcomingURL: String = "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1)"
    
    static let TVsURL: String = "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)"
    
    static let popularMoviesURL: String = "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1"
    
    static let topRatedURL: String = "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1"
}
