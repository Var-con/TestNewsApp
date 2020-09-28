//
//  MainPageNewsCollectionViewCell.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 27.09.2020.
//

import UIKit

class MainPageNewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleView: UIView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var favoriteImage: UIImageView!
    @IBOutlet var favoriteButtonOutlet: UIButton!
    private var cellArticle: Article?
    private var isFavorite: Bool?
    
    @IBAction func addToFavoriteButton(_ sender: Any) {
        if isFavorite! {
            deleteFromFavorite()
        } else {
            addToFavorite()
        }
    }
    func configureWithArticle(from article: Article) {
        cellArticle = article
            nameLabel.text = article.source?.name
            descriptionLabel.text =  article.articleDescription
        guard let imageUrl = article.urlToImage else { return }
        guard let data = ImageManager.shared.getImageData(from: imageUrl) else { return }
        DispatchQueue.main.async {
            self.newsImage.image = UIImage(data: data)
        }
        setupImage()
        setupNameLabel()
        setupDescriptionLabel()
        isFavorite = FavoriteChannelManager.shared.checkFavoriteChannel(with: article.source!.name)
        setupFavoriteImage()
        setupFavoriteButtonLabel()
    }
    
    
    private func setupImage() {
        newsImage.layer.cornerRadius = 20
        newsImage.layer.borderWidth = 2
        newsImage.layer.borderColor = CGColor(red: 0.5, green: 0.3, blue: 0.7, alpha: 1)
        newsImage.layer.shadowRadius = 10
    }
    
    private func setupNameLabel() {
        titleView.layer.cornerRadius = 10
        titleView.layer.borderWidth = 2
        titleView.layer.borderColor = CGColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1)
    }
    
    
    private func setupDescriptionLabel() {
        descriptionView.layer.cornerRadius = 10
        descriptionView.layer.borderWidth = 2
        descriptionView.layer.borderColor = CGColor(red: 0.5, green: 0.3, blue: 0.7, alpha: 1)
    }
    private func setupFavoriteImage() {
        guard let isFavorite = isFavorite else { return }
        var tapGesture: UITapGestureRecognizer?
        if isFavorite {
            favoriteImage.tintColor = .red
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteFromFavorite))
        } else {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(addToFavorite))
        }
        favoriteImage.isUserInteractionEnabled = true
        favoriteImage.addGestureRecognizer(tapGesture!)
    }
    
    private func setupFavoriteButtonLabel() {
        guard let isFavorite = isFavorite else { return }
        if isFavorite {
            favoriteButtonOutlet.setTitle("Delete from favorite", for: .normal)
            
        } else {
            favoriteButtonOutlet.setTitle("Add to favorite", for: .normal)
        }
    }
    
    @objc private func addToFavorite() {
        favoriteImage.tintColor = .red
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 0.7
        pulseAnimation.fromValue = 1
        pulseAnimation.toValue = 0.4
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = 3
        favoriteImage.layer.add(pulseAnimation, forKey: nil)
        favoriteImage.startAnimating()
        isFavorite = true
        FavoriteChannelManager.shared.takeNewFavoriteChannel(with: (cellArticle?.source?.name)!)
        setupFavoriteButtonLabel()
    }
    
    @objc private func deleteFromFavorite() {
        favoriteImage.tintColor = .white
        isFavorite = false
        setupFavoriteButtonLabel()
        FavoriteChannelManager.shared.deleteFromFavorite(with: (cellArticle?.source?.name)!)
    }
    
    
}
