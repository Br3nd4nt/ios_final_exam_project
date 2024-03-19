//
//  ContentViewCell.swift
//  exam_app
//
//  Created by br3nd4nt on 19.03.2024.
//

import UIKit
import SDWebImage

final class ContentViewCell: UICollectionViewCell {
    static let reuseId: String = "reuseId"
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .white
        iv.clipsToBounds = true
        return iv
    }()
    
    func configure(with content: ContentTile) {
        self.imageView.sd_setImage(with: URL(string: content.url))
        self.setupUI()
      }
    
    private func setupUI() {
        self.addSubview(imageView)
        imageView.pinTop(to:self)
        imageView.pinLeft(to: self)
        imageView.pinRight(to: self)
        imageView.pinBottom(to: self)   
    }
}
