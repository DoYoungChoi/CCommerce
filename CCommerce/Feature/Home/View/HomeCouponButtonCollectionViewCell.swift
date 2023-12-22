//
//  HomeCouponButtonCollectionViewCell.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit
import Combine

struct HomeCouponButtonCollectionViewCellViewModel: Hashable {
    var state: CouponState
    enum CouponState {
        case enable
        case disable
    }
}

final class HomeCouponButtonCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeCouponButtonCollectionViewCell"
    
    @IBOutlet private weak var couponButton: UIButton! {
        didSet {
            couponButton.setImage(CCImage.btnActivate, for: .normal)
            couponButton.setImage(CCImage.btnComplete, for: .disabled)
        }
    }
    private weak var didTapCouponDownloaded: PassthroughSubject<Void, Never>?
    
    func setViewModel(
        _ viewModel: HomeCouponButtonCollectionViewCellViewModel,
        _ didTapCouponDownloaded: PassthroughSubject<Void, Never>?
    ) {
        self.didTapCouponDownloaded = didTapCouponDownloaded
        couponButton.isEnabled = switch viewModel.state {
        case .enable:
            true
        case .disable:
            false
        }
    }
    @IBAction private func didTapCouponButton(_ sender: Any) {
        didTapCouponDownloaded?.send()
    }
}

extension HomeCouponButtonCollectionViewCell {
    static func buttonLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = .init(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(37)
        )
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 28, leading: 24, bottom: 20, trailing: 24)
        return section
    }
}
