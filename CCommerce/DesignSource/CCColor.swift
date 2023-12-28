//
//  CCColor.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import UIKit
import SwiftUI

enum CCColor { }

extension CCColor {
    enum UIKit {
        static var bk: UIColor = UIColor(resource: .bk)
        static var wh: UIColor = UIColor(resource: .wh)
        static var coral: UIColor = UIColor(resource: .coral)
        static var yellow: UIColor = UIColor(resource: .yw)
        static var green: UIColor = UIColor(resource: .grn)
        static var keyColorRed: UIColor = UIColor(resource: .keyColorRed)
        static var keyColorRed2: UIColor = UIColor(resource: .keyColorRed2)
        static var keyColorBlue: UIColor = UIColor(resource: .keyColorBlue)
        static var keyColorBlueTrans: UIColor = UIColor(resource: .keyColorBlueTrans)
        
        static var gray0: UIColor = UIColor(resource: .gray0)
        static var gray1: UIColor = UIColor(resource: .gray1)
        static var gray2: UIColor = UIColor(resource: .gray2)
        static var gray3: UIColor = UIColor(resource: .gray3)
        static var gray3Cool: UIColor = UIColor(resource: .gray3Cool)
        static var gray4: UIColor = UIColor(resource: .gray4)
        static var gray5: UIColor = UIColor(resource: .gray5)
        static var icon: UIColor = UIColor(resource: .icon)
    }
}

extension CCColor {
    enum SwiftUI {
        static var bk: Color = Color("bk", bundle: nil)
        static var wh: Color = Color("wh", bundle: nil)
        static var coral: Color = Color("coral", bundle: nil)
        static var yellow: Color = Color("yw", bundle: nil)
        static var green: Color = Color("grn", bundle: nil)
        static var keyColorRed: Color = Color("key-color-red", bundle: nil)
        static var keyColorRed2: Color = Color("key-color-red-2", bundle: nil)
        static var keyColorBlue: Color = Color("key-color-blue", bundle: nil)
        static var keyColorBlueTrans: Color = Color("key-color-blue-trans", bundle: nil)
        
        static var gray0: Color = Color("gray-0", bundle: nil)
        static var gray1: Color = Color("gray-1", bundle: nil)
        static var gray2: Color = Color("gray-2", bundle: nil)
        static var gray3: Color = Color("gray-3", bundle: nil)
        static var gray3Cool: Color = Color("gray-3-ool", bundle: nil)
        static var gray4: Color = Color("gray-4", bundle: nil)
        static var gray5: Color = Color("gray-5", bundle: nil)
        static var icon: Color = Color("icon", bundle: nil)
    }
}
