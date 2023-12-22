//
//  HomeViewController.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    enum Section: Int {
        case banner
        case horizontalProducts
        case verticalProducts
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var compositionalLayout: UICollectionViewCompositionalLayout = setCompositionalLayout()
    private var viewModel: HomeViewModel = .init()
    private var subscriptions: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
        setDataSource()
        collectionView.collectionViewLayout = compositionalLayout
        
        viewModel.process(action: .loadData)
    }
    
    private static func setCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, _ in
            switch Section(rawValue: section) {
            case .banner:
                return HomeBannerCollectionViewCell.bannerLayout()
            case .horizontalProducts:
                return HomeProductCollectionViewCell.horizontalProductsLayout()
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
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
           collectionView: collectionView,
           cellProvider: { [weak self] collectionView, indexPath, viewModel in
               switch Section(rawValue: indexPath.section) {
               case .banner:
                   return self?.bannerCell(collectionView, indexPath, viewModel)
               case .horizontalProducts, .verticalProducts:
                   return self?.productCell(collectionView, indexPath, viewModel)
               case .none:
                   return .init()
               }
               
           }
       )
    }
    
    private func applySnapshot() {
        var snapshot: NSDiffableDataSourceSnapshot<Section, AnyHashable> = .init()
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
        }
        
        if let verticalProductViewModels = viewModel.state.collectionViewModels.verticalProductViewModels {
            snapshot.appendSections([.verticalProducts])
            snapshot.appendItems(
                verticalProductViewModels,
                toSection: .verticalProducts
            )
        }
        
        dataSource?.apply(snapshot)
    }
    
    private func bannerCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeBannerCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeBannerCollectionViewCell.identifier,
                for: indexPath
              ) as? HomeBannerCollectionViewCell
        else { return .init() }
        
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func productCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeProductCollectionViewCellViewModel,
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeProductCollectionViewCell.identifier,
                for: indexPath
              ) as? HomeProductCollectionViewCell
        else { return .init() }
        
        cell.setViewModel(viewModel)
        return cell
    }
}

#Preview {
    UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! HomeViewController
}
