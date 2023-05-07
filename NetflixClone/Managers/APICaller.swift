//
//  APICaller.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 7.05.2023.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    func fetchMovies(completion: @escaping(String) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
        
    }
}
