//
//  UIImageViewExtensions.swift
//  ImageSlideShow
//
//  Created by Daniel Hjärtström on 2020-01-30.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadAsync(_ url: URL?) {
        guard let url = url else { return }
        DispatchQueue.global(qos: .background).async {
            do {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
