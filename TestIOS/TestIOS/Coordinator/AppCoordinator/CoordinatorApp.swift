//
//  Coordinator.swift
//  TestIOS
//
//  Created by Developer on 27.03.2023.
//

import Foundation
import SwiftUINavigation

class CoordinatorApp: ObservableObject {
    
    enum Route {
        case navigationDetail(coordinator: DetailCoordinator)
    }
    
    @Published var route: Route?
    var viewModel: PersonListViewModel
    
    init(viewModel: PersonListViewModel) {
        self.viewModel = viewModel
        viewModel.onResult = {[weak self] result in
            switch result {
            case .navigationDetail(let user):
                self?.getInfo(user: user)
            case .navigationBack:
                self?.route = nil
            }
        }
    }
    
    func getInfo(user: UserDetails) {
        let coordinator = DetailCoordinator(viewModel: PersonDetailViewModel(userService: UserService()), user: user)
        coordinator.onResult = {[weak self] result in
            switch result {
            case .navigationBack:
                self?.route = nil
            }
        }
        self.route = .navigationDetail(coordinator: coordinator)
    }
}
