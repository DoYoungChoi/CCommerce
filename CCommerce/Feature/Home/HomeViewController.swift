//
//  HomeViewController.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    enum Section: Int {
        case banner
        case horizontalProducts
        case homeSeperator1
        case couponButton
        case verticalProducts
        case homeSeperator2
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private lazy var dataSource: DataSource = setDataSource()
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = setCompositionalLayout()
    private var viewModel: HomeViewModel = .init()
    private var subscriptions: [AnyCancellable] = []
    private var currentSections: [Section] {
        dataSource.snapshot().sectionIdentifiers as [Section]
    }
    private var didTapCouponDownloaded: PassthroughSubject<Void, Never> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
        collectionView.collectionViewLayout = compositionalLayout
        
        viewModel.process(action: .loadCoupons)
        viewModel.process(action: .loadData)
    }
    
    private func setCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch self?.currentSections[section] {
            case .banner:
                return HomeBannerCollectionViewCell.bannerLayout()
            case .horizontalProducts:
                return HomeProductCollectionViewCell.horizontalProductsLayout()
            case .homeSeperator1, .homeSeperator2:
                return HomeSeperatorCollectionViewCell.seperatorLayout()
            case .couponButton:
                return HomeCouponButtonCollectionViewCell.buttonLayout()
            case .verticalProducts:
                return HomeProductCollectionViewCell.verticalProductsLayout()
            case .none:
                return nil
            }
        }
    }
    
    private func binding() {
        viewModel.state.$collectionViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }.store(in: &subscriptions)
        
        didTapCouponDownloaded
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.viewModel.process(action: .didTapCouponButton)
            }.store(in: &subscriptions)
    }
    
    private func setDataSource() -> DataSource {
        return UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, viewModel in
                switch self?.currentSections[indexPath.section] {
                case .banner:
                    return self?.bannerCell(collectionView, indexPath, viewModel)
                case .horizontalProducts, .verticalProducts:
                    return self?.productCell(collectionView, indexPath, viewModel)
                case .couponButton:
                    return self?.couponButtonCell(collectionView, indexPath, viewModel)
                case .homeSeperator1, .homeSeperator2:
                    return self?.seperatorCell(collectionView, indexPath, viewModel)
                case .none:
                    return .init()
                }
                
            }
        )
    }
    
    private func applySnapshot() {
        var snapshot: Snapshot = .init()
        if let bannerViewModels = viewModel.state.collectionViewModels.bannerViewModels {
            snapshot.appendSections([.banner])
            snapshot.appendItems(
                bannerViewModels,
                toSection: .banner
            )
        }
        
        if let horizontalProductViewModels = viewModel.state.collectionViewModels.horizontalProductViewModels {
            snapshot.appendSections([.horizontalProducts])
            snapshot.appendItems(
                horizontalProductViewModels,
                toSection: .horizontalProducts
            )
            
            snapshot.appendSections([.homeSeperator1])
            snapshot.appendItems(
                viewModel.state.collectionViewModels.seperator1,
                toSection: .homeSeperator1
            )
        }
        
        if let couponState = viewModel.state.collectionViewModels.couponState {
            snapshot.appendSections([.couponButton])
            snapshot.appendItems(
                couponState,
                toSection: .couponButton
            )
        }
        
        if let verticalProductViewModels = viewModel.state.collectionViewModels.verticalProductViewModels {
            snapshot.appendSections([.verticalProducts])
            snapshot.appendItems(
                verticalProductViewModels,
                toSection: .verticalProducts
            )
        }
        
        dataSource.apply(snapshot)
    }
    
}

extension HomeViewController {
    
    private func bannerCell(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ viewModel: AnyHashable
    ) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeBannerCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeBannerCollectionViewCell.identifier,
                for: indexPath
              ) as? HomeBannerCollectionViewCell
        else { return .init() }
        
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func productCell(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ viewModel: AnyHashable
    ) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeProductCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeProductCollectionViewCell.identifier,
                for: indexPath
              ) as? HomeProductCollectionViewCell
        else { return .init() }
        
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func couponButtonCell(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ viewModel: AnyHashable
    ) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeCouponButtonCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeCouponButtonCollectionViewCell.identifier,
                for: indexPath
              ) as? HomeCouponButtonCollectionViewCell
        else { return .init() }
        
        cell.setViewModel(
            viewModel,
            didTapCouponDownloaded
        )
        return cell
    }
    
    private func seperatorCell(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ viewModel: AnyHashable
    ) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeSeperatorCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeSeperatorCollectionViewCell.identifier,
                for: indexPath
              ) as? HomeSeperatorCollectionViewCell
        else { return .init() }
        
        cell.setViewModel(viewModel)
        return cell
    }
}

#Preview {
    UIStoryboard(
        name: "Home",
        bundle: nil
    ).instantiateInitialViewController() as! HomeViewController
}
