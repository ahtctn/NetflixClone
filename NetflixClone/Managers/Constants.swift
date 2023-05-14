//
//  Constants.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 7.05.2023.
//

import Foundation

enum Constants {
    //MARK: BASE URL
    static let API_KEY: String = "4c3320637d3f0260500a8287780a9baf"
    static let baseURL: String = "https://api.themoviedb.org"
    
    //MARK: GOOGLE API KEY
    static let youtubeBaseURL: String = "https://youtube.googleapis.com/youtube/v3/search?"
    static let youtubeAPI_KEY: String = "AIzaSyCjDi_aXMc7PgPpDV0c-VMbYnJct9Wtyvk"
    
    //MARK: PATHS
    static let moviesURL: String = "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)"
    
    static let upcomingURL: String = "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1)"
    
    static let TVsURL: String = "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)"
    
    static let popularMoviesURL: String = "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1"
    
    static let topRatedURL: String = "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1"
    
    static let searchMoviesURL: String = "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_video=false&page=1&with_watch_monetization_types=flatrate"
    
    static let searchFilterListingURL: String = "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query="
}
