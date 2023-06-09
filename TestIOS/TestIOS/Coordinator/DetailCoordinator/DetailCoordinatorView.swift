//
//  DetailCoordinatorView.swift
//  TestIOS
//
//  Created by Developer on 27.03.2023.
//

import SwiftUI
import SwiftUINavigation

struct DetailCoordinatorView: View {
    
    @ObservedObject  var coordinator: DetailCoordinator
    
    var body: some View {
        NavigationView {
            ZStack {
                PersonDetailView(viewModel: coordinator.viewModel,
                                 userDetails: coordinator.user)
            }
        }
    }
}
