//
//  HomeBannerCollectionViewCell.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit

struct HomeBannerCollectionViewCellViewModel: Hashable {
    let bannerImage: UIImage
}

class HomeBannerCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeBannerCollectionViewCell"
    @IBOutlet weak var imageView: UIImageView!
    
    func setViewModel(_ viewModel: HomeBannerCollectionViewCellViewModel) {
        imageView.image = viewModel.bannerImage
    }
}
