//
//  OptionRootView.swift
//  CCommerce
//
//  Created by dodor on 12/27/23.
//

import SwiftUI

struct OptionRootView: View {
    @ObservedObject var viewModel: OptionViewModel
    
    var body: some View {
        Text("옵션 화면")
    }
}

#Preview {
    OptionRootView(
        viewModel: .init()
    )
}
