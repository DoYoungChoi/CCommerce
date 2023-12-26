//
//  HomeThemeHeaderCollectionReusableView.swift
//  CCommerce
//
//  Created by dodor on 12/23/23.
//

import UIKit

struct HomeThemeHeaderCollectionReusableViewModel: Hashable {
    var headerText: String
}

final class HomeThemeHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier: String = "HomeThemeHeaderCollectionReusableView"
    @IBOutlet weak var themeHeaderLabel: UILabel!
    
    func setViewModel(_ viewModel: HomeThemeHeaderCollectionReusableViewModel) {
        themeHeaderLabel.text = viewModel.headerText
    }
}
