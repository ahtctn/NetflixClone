//
//  CollectionViewTableViewCell.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 5.05.2023.
//

import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: MoviePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    //MARK: STATICS
    static let id: String = "CollectionViewTableViewCell"
    weak var delegate: CollectionTableViewCellDelegate?
    
    private var movieTitles: [MovieModel] = [MovieModel]()
    
    //MARK: UI ELEMENTS
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.id)
        return cv
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with movieTitles: [MovieModel]) {
        self.movieTitles = movieTitles
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath) {
        print("Downloading \(movieTitles[indexPath.row].originalTitle ?? "Invalid")") 
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.id, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let model = movieTitles[indexPath.row].posterPath else { return UICollectionViewCell()}
        
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = movieTitles[indexPath.row]
        guard let movieName = movie.originalTitle ?? movie.originalName else { return }
        APICaller.shared.openMovieTrailersInYT(with: movieName + " Trailer") {[weak self] result in
            switch result {
            case .success(let videoElement):
                let movieTitles = self?.movieTitles[indexPath.row]
                
                guard let movieTitleOverview = movieTitles?.overview else { return }
                
                guard let strongSelf = self else { return }
                
                let viewModel = MoviePreviewViewModel(title: movieName, youtubeView: videoElement, titleOverview: movieTitleOverview)
                self?.delegate?.collectionTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {[weak self] _ in
            let downloadAction = UIAction(title: "Download",
                                          subtitle: nil,
                                          image: nil,
                                          identifier: nil,
                                          discoverabilityTitle: nil,
                                          attributes: .keepsMenuPresented,
                                          state: .off) { _ in
                self?.downloadTitleAt(indexPath: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        
        return config
    }
}

