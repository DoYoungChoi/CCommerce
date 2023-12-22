//
//  Numeric+Extension.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import Foundation

extension Numeric {
    var wonString: String {
        let formatter: NumberFormatter = .init()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return (formatter.string(for: self) ?? "") + "원"
    }
}
