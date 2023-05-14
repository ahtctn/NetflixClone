//
//  SearchResultsViewController.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 11.05.2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: MoviePreviewViewModel)
}

class SearchResultsViewController: UIViewController {

    public var movies: [MovieModel] = [MovieModel]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.id)
        return cv
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegations()
    }
    
    private func delegations() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchResultsCollectionView.frame = view.bounds
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.id, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell()}
        
        let movies = movies[indexPath.row]
        cell.configure(with: movies.posterPath ?? "wrongPosterpath")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movies = movies[indexPath.row]
        let movieName = movies.originalTitle ?? "yanlış title"
        
        APICaller.shared.openMovieTrailersInYT(with: movies.originalTitle ?? "yanlış title") { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.delegate?.searchResultsViewControllerDidTapItem(MoviePreviewViewModel(title: movies.originalTitle ?? "yanlış title", youtubeView: videoElement, titleOverview: movies.overview ?? "yanlış overview"))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
