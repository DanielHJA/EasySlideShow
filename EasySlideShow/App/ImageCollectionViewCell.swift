//
//  ImageCollectionViewCell.swift
//  ImageSlideShow
//
//  Created by Daniel Hjärtström on 2020-01-30.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.clipsToBounds = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()

    func configure(_ item: Any, aspect: UIView.ContentMode) {
        imageView.contentMode = .scaleAspectFill

        if let item = item as? UIImage {
            configureForImage(item)
        }
        
        if let item = item as? URL {
            configureForURI(item)
        }
        
        if let item = item as? String {
            guard let url = URL(string: item) else { return }
            configureForURI(url)
        }
        
    }
    
    private func configureForImage(_ image: UIImage) {
        imageView.image = image
    }
    
    private func configureForURI(_ url: URL) {
        imageView.loadAsync(url)
    }
    
}
