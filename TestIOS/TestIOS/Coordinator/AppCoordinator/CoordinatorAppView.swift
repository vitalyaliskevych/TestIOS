//
//  CoordinatorAppViewModel.swift
//  TestIOS
//
//  Created by Developer on 27.03.2023.
//

import SwiftUI
import SwiftUINavigation

struct CoordatatorAppView: View {
    
    @ObservedObject var coordinator: CoordinatorApp
    
    var body: some View {
        NavigationView {
            ZStack {
                PersonListView(viewModel: coordinator.viewModel)
                NavigationLink(
                    unwrapping: $coordinator.route,
                    case: /CoordinatorApp.Route.navigationDetail,
                    destination: {(coordinator: Binding<DetailCoordinator>) in
                        DetailCoordinatorView(
                            coordinator: coordinator.wrappedValue).navigationBarBackButtonHidden(true)
                    }, onNavigate: {_ in}) {}
            }
        }
    }
}
