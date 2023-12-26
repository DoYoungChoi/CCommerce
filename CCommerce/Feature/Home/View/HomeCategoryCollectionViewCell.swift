//
//  HomeCategoryCollectionViewCell.swift
//  CCommerce
//
//  Created by dodor on 12/26/23.
//

import UIKit

struct HomeCategoryCollectionViewCellViewModel: Hashable { 
    var image: UIImage
    var categoryName: String
}

final class HomeCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeCategoryCollectionViewCell"
    
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var categoryNameLabel: UILabel!
    
    func setViewModel(_ viewModel: HomeCategoryCollectionViewCellViewModel) {
        categoryImageView.image = viewModel.image
        categoryNameLabel.text = viewModel.categoryName
    }
}

extension HomeCategoryCollectionViewCell {
    static func categoryLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .absolute(80),
            heightDimension: .absolute(80)
        )
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        item.contentInsets = .init(top: 13, leading: 12, bottom: 13, trailing: 12)
        
        let groupSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 13, leading: 29, bottom: 13, trailing: 29)
        return section
    }
}
