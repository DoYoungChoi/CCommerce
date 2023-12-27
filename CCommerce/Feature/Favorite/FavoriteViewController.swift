//
//  FavoriteViewController.swift
//  CCommerce
//
//  Created by dodor on 12/26/23.
//

import UIKit
import Combine

final class FavoriteViewController: UIViewController {

    private typealias DataSource = UITableViewDiffableDataSource<Section, AnyHashable>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private enum Section: Int {
        case favorite
    }
    
    @IBOutlet private weak var tableView: UITableView!
    private lazy var dataSource: DataSource = setDataSource()
    private var viewModel: FavoriteViewModel = .init()
    private var subscriptions: [AnyCancellable] = []
    private var currentSection: [Section] {
        dataSource.snapshot().sectionIdentifiers as [Section]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binding()
        
        viewModel.process(action: .getFavoritesFromAPI)
    }

    private func binding() {
        viewModel.state.$favoriteViewModels
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }.store(in: &subscriptions)
    }
    
    private func setDataSource() -> DataSource {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { [weak self] tableView, indexPath, viewModel in
                switch self?.currentSection[indexPath.section] {
                case .favorite:
                    return self?.favoriteCell(tableView, indexPath, viewModel)
                case .none:
                    return .init()
                }
            }
        )
    }
    
    private func applySnapshot() {
        var snapshot: Snapshot = .init()
        
        if let favoriteViewModels = viewModel.state.favoriteViewModels {
            snapshot.appendSections([.favorite])
            snapshot.appendItems(
                favoriteViewModels,
                toSection: .favorite
            )
        }
        
        dataSource.apply(snapshot)
    }
}

extension FavoriteViewController {
    
    private func favoriteCell(
        _ tableView: UITableView,
        _ indexPath: IndexPath,
        _ viewModel: AnyHashable
    ) -> UITableViewCell {
        guard let viewModel = viewModel as? FavoriteTableViewCellViewModel,
              let cell = tableView.dequeueReusableCell(
                withIdentifier: FavoriteTableViewCell.identifier,
                for: indexPath
              ) as? FavoriteTableViewCell
        else { return .init() }
        
        cell.setViewModel(viewModel)
        return cell
    }
}
