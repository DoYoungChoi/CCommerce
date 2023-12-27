//
//  FavoriteTableViewCell.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import UIKit
import Kingfisher

struct FavoriteTableViewCellViewModel: Hashable {
    var imageURL: String
    var productName: String
    var productPrice: String
}

final class FavoriteTableViewCell: UITableViewCell {
    
    static let identifier: String = "FavoriteTableViewCell"
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var purchaseButton: UIButton!
    
    func setViewModel(_ viewModel: FavoriteTableViewCellViewModel) {
        productImageView.kf.setImage(with: URL(string: viewModel.imageURL))
        productNameLabel.text = viewModel.productName
        productPriceLabel.text = viewModel.productPrice
    }
}
