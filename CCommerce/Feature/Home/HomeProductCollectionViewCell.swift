//
//  HomeProductCollectionViewCell.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit

struct HomeProductCollectionViewCellViewModel: Hashable {
    let imageURLString: String
    let name: String
    let discountReason: String
    let originalPrice: String
    let discountPrice: String
}

class HomeProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeProductCollectionViewCell"
    @IBOutlet weak var productImageView: UIImageView! {
        didSet {
            productImageView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDiscountReasonLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    
    func setViewModel(_ viewModel: HomeProductCollectionViewCellViewModel) {
//        productImageView.image =
        productNameLabel.text = viewModel.name
        productDiscountReasonLabel.text = viewModel.discountReason
        originalPriceLabel.attributedText = NSMutableAttributedString(
            string: viewModel.originalPrice,
            attributes: [
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        discountPriceLabel.text = viewModel.discountPrice
    }
}
