//
//  MainPageCollectionViewController.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 27.09.2020.
//

import UIKit

class MainPageCollectionViewController: UICollectionViewController {
    
    var groupNews: [MainNews] = []
    var allNews: [Article] = []
    private let storageManager = StorageManager()
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        getNews()
    }
    
    func getNews() {
        for url in URLSofMainNews.allCases {
            NetworkManager.shared.fetchNews(from: url.rawValue) { (news) in
                self.groupNews.append(news)
                self.getArticles(from: self.groupNews)
            }
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()            
        }
    }
    
    func getArticles(from groups: [MainNews]) {
        for item in groups {
            if let articles = item.articles {
                allNews.append(contentsOf: articles)
                storageManager.addNewsToStorage(with: articles)
            }
            
        }
        reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return allNews.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "mainPageNewsCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainPageNewsCollectionViewCell
        cell.favoriteImage.tintColor = .white
        cell.configureWithArticle(from: allNews[indexPath.row])
        return cell
    }
    

}

