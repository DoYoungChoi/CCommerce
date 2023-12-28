//
//  FavoritePurchaseButton.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import UIKit

final class FavoritePurchaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        layer.cornerRadius = 5
        layer.borderColor = CCColor.UIKit.keyColorBlue.cgColor
        layer.borderWidth = 1
        setTitle("구매하기", for: .normal)
        setTitleColor(CCColor.UIKit.keyColorBlue, for: .normal)
    }
}
