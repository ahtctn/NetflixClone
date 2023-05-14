//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 5.05.2023.
//

import UIKit

enum MovieSections: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovies: MovieModel?
    private var headerView: HomeHeaderUIView?
    

    let sectionTitles: [String] = ["Trending Movies","Trending TV", "Popular Now", "Upcoming Movies", "Top Rated"]
    
    
    private let homeFeedTable: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.id)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        self.delegations()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

    private func delegations() {
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        self.configureNavBar()
        
        headerView = HomeHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        self.configureHeroHeaderView()
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil),
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func configureHeroHeaderView() {
        APICaller.shared.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.randomTrendingMovies = movies.randomElement()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.id, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell()}
        cell.delegate = self
        
        switch indexPath.section {
        case MovieSections.TrendingMovies.rawValue:
            APICaller.shared.fetchMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case MovieSections.TrendingTV.rawValue:
            APICaller.shared.fetchTVs { result in
                switch result {
                case .success(let tv):
                    cell.configure(with: tv)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case MovieSections.Popular.rawValue:
            APICaller.shared.fetchPopularMovies { result in
                switch result {
                case .success(let popularMovies):
                    cell.configure(with: popularMovies)
                case .failure(let error):
                    print("Error varr: \(error)")
                    print(error.localizedDescription)
                }
            }
        case MovieSections.Upcoming.rawValue:
            APICaller.shared.fetchUpcomingMovies { result in
                switch result {
                case.success(let upcomingMovies):
                    cell.configure(with: upcomingMovies)
                case .failure(let error):
                    print("Error varr: \(error)")
                    print(error.localizedDescription)
                }
            }
        case MovieSections.TopRated.rawValue:
            APICaller.shared.fetchTopRatedMovies { result in
                switch result {
                case .success(let topRatedMovies):
                    cell.configure(with: topRatedMovies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
         return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionTableViewCellDelegate {
    func collectionTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: MoviePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = MoviePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
