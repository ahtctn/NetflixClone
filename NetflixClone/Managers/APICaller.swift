//
//  APICaller.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 7.05.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case invalidDecoder
    case invalidResponse
}

typealias HandlerMovie = (Result <[MovieModel], NetworkError>) -> Void
typealias HandlerTV = (Result <[MovieModel], NetworkError>) -> Void
typealias HandlerUpcoming = (Result <[MovieModel], NetworkError>) -> Void
typealias HandlerPopular = (Result <[MovieModel], NetworkError>) -> Void
typealias HandlerTopRated = (Result <[MovieModel], NetworkError>) -> Void
typealias HandlerSearch = (Result <[MovieModel], NetworkError>) -> Void
typealias HandlerYTVideo = (Result <VideoElementModel, NetworkError>) -> Void

class APICaller {
    static let shared = APICaller()
    
    func fetchMovies(completion: @escaping HandlerMovie) {
        
        guard let url = URL(string: Constants.moviesURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let jsonDecoder = JSONDecoder()
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                print("fetch movies response error")
                completion(.failure(.invalidResponse))
                    return
                }
            
            do {
                let results = try jsonDecoder.decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results)) 
            } catch {
                completion(.failure(.invalidDecoder))
            }
        }
        
        task.resume()
    }
    
    func fetchTVs(completion: @escaping HandlerTV) {
        guard let url = URL(string: Constants.TVsURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                print("fetch tvs response error")
                completion(.failure(.invalidResponse))
                    return
                }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(.invalidDecoder))
            }
            
            
        }
        task.resume()
    }
    
    func fetchUpcomingMovies(completion: @escaping HandlerUpcoming) {
        guard let url = URL(string: Constants.upcomingURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                print("fetch upcoming movies response error")
                completion(.failure(.invalidResponse))
                    return
                }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }catch let DecodingError.dataCorrupted(context) {
                print(context)
                print("Data corrupted")
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                print("Key not found")
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                print("Value not found")
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                print("Type mismatch")
            } catch {
                completion(.failure(.invalidDecoder))
            }
        }
        task.resume()
        
    }
    
    func fetchPopularMovies(completion: @escaping HandlerPopular) {
        guard let url = URL(string: Constants.popularMoviesURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                print("fetch popular movies response error")
                completion(.failure(.invalidResponse))
                    return
                }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                print("Data corrupted")
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                print("Key not found")
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                print("Value not found")
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                print("Type mismatch")
            } catch {
                completion(.failure(.invalidDecoder))
            }
            
        }
        task.resume()
    }
    
    func fetchTopRatedMovies(completion: @escaping HandlerTopRated) {
        guard let url = URL(string: Constants.topRatedURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                print("fetch top rated movies response error")
                completion(.failure(.invalidResponse))
                    return
                }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(.invalidDecoder))
            }
        }
        task.resume()
    }
    
    func getSearchMovies(completion: @escaping HandlerSearch) {
        guard let url = URL(string: Constants.searchMoviesURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                print("fetch top rated movies response error")
                completion(.failure(.invalidResponse))
                    return
                }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(.invalidDecoder))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping HandlerSearch) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.searchFilterListingURL)\(query)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                print("fetch top rated movies response error")
                completion(.failure(.invalidResponse))
                    return
                }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(.invalidDecoder))
            }
        }
        task.resume()
    }
    
    func openMovieTrailersInYT(with query: String, completion: @escaping HandlerYTVideo) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&key=\(Constants.youtubeAPI_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode(YoutubeSearchResultsModel.self, from: data)
                completion(.success(results.items[0]))
                
            } catch {
                print(error.localizedDescription)
                completion(.failure(.invalidDecoder))
            } 
        }
        task.resume() 
    }
}
