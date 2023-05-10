//
//  DownloadsViewController.swift
//  NetflixClone
//
//  Created by Ahmet Ali ÇETİN on 5.05.2023.
//

import UIKit

class DownloadsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.basicNavigationTitleArragments()
    }
    
    private func basicNavigationTitleArragments() {
        view.backgroundColor = .systemBackground
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
}
