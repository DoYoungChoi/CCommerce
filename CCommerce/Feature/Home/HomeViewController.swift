//
//  HomeViewController.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    enum Section: Int {
        case banner
        case horizontalProducts
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var compositionalLayout: UICollectionViewCompositionalLayout = {
        UICollectionViewCompositionalLayout { section, _ in
            switch Section(rawValue: section) {
            case .banner:
                let itemSize: NSCollectionLayoutSize = .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
                
                let groupSize: NSCollectionLayoutSize = .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalWidth(165 / 393)
                )
                let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section: NSCollectionLayoutSection = .init(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            case .horizontalProducts:
                let itemSize: NSCollectionLayoutSize = .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
                
                let groupSize: NSCollectionLayoutSize = .init(
                    widthDimension: .absolute(117),
                    heightDimension: .estimated(224)
                )
                let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section: NSCollectionLayoutSection = .init(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 30, leading: 33, bottom: 0, trailing: 33)
                return section
            case .none:
                return nil
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, viewModel in
                switch Section(rawValue: indexPath.section) {
                case .banner:
                    guard let viewModel = viewModel as? HomeBannerCollectionViewCellViewModel,
                          let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: HomeBannerCollectionViewCell.identifier,
                            for: indexPath
                          ) as? HomeBannerCollectionViewCell
                    else { return .init() }
                    
                    cell.setViewModel(viewModel)
                    return cell
                case .horizontalProducts:
                    guard let viewModel = viewModel as? HomeProductCollectionViewCellViewModel,
                          let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: HomeProductCollectionViewCell.identifier,
                            for: indexPath
                          ) as? HomeProductCollectionViewCell
                    else { return .init() }
                    
                    cell.setViewModel(viewModel)
                    return cell
                case .none:
                    return .init()
                }
                
            }
        )
        
        var snapShot: NSDiffableDataSourceSnapshot<Section, AnyHashable> = .init()
        snapShot.appendSections([.banner])
        snapShot.appendItems(
            [
                HomeBannerCollectionViewCellViewModel(bannerImage: UIImage(resource: .slide1)),
                HomeBannerCollectionViewCellViewModel(bannerImage: UIImage(resource: .slide2)),
                HomeBannerCollectionViewCellViewModel(bannerImage: UIImage(resource: .slide3)),
            ],
            toSection: .banner
        )
        
        snapShot.appendSections([.horizontalProducts])
        snapShot.appendItems(
            [
                HomeProductCollectionViewCellViewModel(
                    imageURLString: "",
                    name: "iphone11",
                    discountReason: "쿠폰 할인가",
                    originalPrice: "1,100,000원",
                    discountPrice: "1,000,000원"
                ),
                HomeProductCollectionViewCellViewModel(
                    imageURLString: "",
                    name: "iphone12",
                    discountReason: "쿠폰 할인가",
                    originalPrice: "1,200,000원",
                    discountPrice: "1,100,000원"
                ),
                HomeProductCollectionViewCellViewModel(
                    imageURLString: "",
                    name: "iphone13",
                    discountReason: "쿠폰 할인가",
                    originalPrice: "1,300,000원",
                    discountPrice: "1,200,000원"
                ),
                HomeProductCollectionViewCellViewModel(
                    imageURLString: "",
                    name: "iphone14",
                    discountReason: "쿠폰 할인가",
                    originalPrice: "1,400,000원",
                    discountPrice: "1,300,000원"
                ),
                HomeProductCollectionViewCellViewModel(
                    imageURLString: "",
                    name: "iphone15",
                    discountReason: "쿠폰 할인가",
                    originalPrice: "1,500,000원",
                    discountPrice: "1,400,000원"
                ),
            ],
            toSection: .horizontalProducts
        )
        dataSource?.apply(snapShot)
        
        collectionView.collectionViewLayout = compositionalLayout
    }
    
}

#Preview {
    UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! HomeViewController
}
