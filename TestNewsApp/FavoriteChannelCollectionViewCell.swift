//
//  FavoriteChannelCollectionViewCell.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 28.09.2020.
//

import UIKit

class FavoriteChannelCollectionViewCell: UICollectionViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleView: UIView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var favoriteImage: UIImageView!
    @IBOutlet var favoriteButtonOutlet: UIButton!
    private var cellChannel: String?
    
    @IBAction func addToFavoriteButton(_ sender: Any) {
        deleteFromFavorite()
    }
    func configureWithChannel(from channelName: String) {
        cellChannel = channelName
        nameLabel.text = channelName
        setupNameLabel()
        setupDescriptionLabel()
        setupFavoriteImage()
        setupFavoriteButtonLabel()
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
        
        favoriteImage.tintColor = .red
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteFromFavorite))
        
        favoriteImage.isUserInteractionEnabled = true
        favoriteImage.addGestureRecognizer(tapGesture)
    }
    
    private func setupFavoriteButtonLabel() {
            favoriteButtonOutlet.setTitle("Delete from favorite", for: .normal)

    }
    
    @objc private func deleteFromFavorite() {
        FavoriteChannelManager.shared.deleteFromFavorite(with: cellChannel!)
    }
    
    
}
