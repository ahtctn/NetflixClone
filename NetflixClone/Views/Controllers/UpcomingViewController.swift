//
//  UpcomingViewController.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 5.05.2023.
//

import UIKit

class UpcomingViewController: UIViewController {

    private var upcomingMovies: [MovieModel] = [MovieModel]()
    
    private let upcomingTableView: UITableView = {
        let tv = UITableView()
        tv.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.id)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.basicNavigationTitleArragments()
        view.addSubview(upcomingTableView)
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        
        self.fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTableView.frame = view.bounds
    }
    
    private func basicNavigationTitleArragments() {
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func fetchUpcoming() {
        APICaller.shared.fetchUpcomingMovies { [weak self] result in
            switch result {
            case .success(let upcomingMovies):
                self?.upcomingMovies = upcomingMovies
                DispatchQueue.main.async {
                    self?.upcomingTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.id, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        let title = upcomingMovies[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: title.originalTitle ?? title.originalName ?? "başarısız titleName", posterURL: title.posterPath ?? "başarısız posterpath"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
     
    
}
