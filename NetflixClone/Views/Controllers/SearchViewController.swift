//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 5.05.2023.
//

import UIKit

class SearchViewController: UIViewController {

    private var moviesTitle: [MovieModel] = [MovieModel]()
    
    private let searchTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.id)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.basicNavigationTitleArragments()
        self.addSubviews()
        self.fetchSearchMovies()
    }
    
    private func basicNavigationTitleArragments() {
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func addSubviews() {
        view.addSubview(searchTable)
        
        searchTable.delegate = self
        searchTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTable.frame = view.bounds
        
    }
    
    private func fetchSearchMovies() {
        APICaller.shared.getSearchMovies { result in
            switch result {
            case .success(let movies):
                self.moviesTitle = movies
                
                DispatchQueue.main.async {
                    self.searchTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.id, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        let moviesTitle = moviesTitle[indexPath.row]
        let model = TitleViewModel(titleName: moviesTitle.originalName ?? moviesTitle.originalTitle ?? "başarısız titleName", posterURL: moviesTitle.posterPath ?? "başarısız posterpath")
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
