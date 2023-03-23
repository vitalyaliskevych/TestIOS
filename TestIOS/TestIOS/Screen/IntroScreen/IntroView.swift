//
//  IntroView.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import SwiftUI

struct IntroView: View {
    
    @ObservedObject var viewModel: IntroViewModelImpl

    var body: some View {
        Text(viewModel.isUserDeleted ? "Deleted User" : viewModel.firstName)
            .onAppear(perform: { viewModel.getUserDetails() })
            .foregroundColor(viewModel.isUserDeleted ? .red : .primary)
    }
}
