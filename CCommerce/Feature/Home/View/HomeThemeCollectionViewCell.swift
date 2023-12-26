//
//  HomeThemeCollectionViewCell.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit
import Kingfisher

struct HomeThemeCollectionViewCellViewModel: Hashable {
    let themeImageURL: String
}

final class HomeThemeCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeThemeCollectionViewCell"
    
    @IBOutlet weak var themeImageView: UIImageView!
    
    func setViewModel(_ viewModel: HomeThemeCollectionViewCellViewModel) {
        themeImageView.kf.setImage(with: URL(string: viewModel.themeImageURL))
    }
}

extension HomeThemeCollectionViewCell {
    static func themeLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        
        let groupFractionWidth: CGFloat = 0.7
        let groupSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(groupFractionWidth),
            heightDimension: .fractionalWidth(groupFractionWidth * 142 / 286)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        
        let headerSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(65)
        )
        let header: NSCollectionLayoutBoundarySupplementaryItem = .init(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        return section
    }
}
