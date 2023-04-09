//
//  CustomImageView.swift
//  Part1
//
//  Created by Prachit on 04/04/23.
//

import UIKit

class CustomImageView: UIImageView {
    
    private let cache = NSCache<NSURL,UIImage>()
    private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageView()
    }
    
    private func setupImageView() {
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func loadImage(from url: URL) {
        
        // if image is cached already
        if let cacheImage = cache.object(forKey: url as NSURL) {
            self.image = cacheImage
            self.updateHeightConstraint()
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let error , error != nil else { return }
            
            if let data = data {
                if let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: url as NSURL)
                    DispatchQueue.main.async {
                        self.image = image
                        self.updateHeightConstraint()
                    }
                }
            }
        }.resume()
    }
    
    private func updateHeightConstraint() {
        guard let image = self.image else { return  }
        let imageRatio = image.size.height / image.size.width
        if let heightConstraint = self.heightConstraint {
            heightConstraint.isActive = false
        }
        self.heightConstraint = self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: imageRatio)
        self.heightConstraint?.isActive = true

    }

}
