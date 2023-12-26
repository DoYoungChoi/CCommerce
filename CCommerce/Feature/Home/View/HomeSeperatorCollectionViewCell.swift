//
//  HomeSeperatorCollectionViewCell.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit

struct HomeSeperatorCollectionViewCellViewModel: Hashable { 
    let id: UUID = UUID()
}

final class HomeSeperatorCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeSeperatorCollectionViewCell"
    
    func setViewModel(_ viewModel: HomeSeperatorCollectionViewCellViewModel) {
        contentView.backgroundColor = CCColor.gray1
    }
}

extension HomeSeperatorCollectionViewCell {
    static func seperatorLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(11)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .zero
        return section
    }
}
