//
//  DetailCoordinator.swift
//  TestIOS
//
//  Created by Developer on 27.03.2023.
//

import Foundation
import SwiftUI

class DetailCoordinator: ObservableObject {

    enum Result {
        case navigationBack
    }
    
    var onResult: ((Result) -> Void)?
    var viewModel: PersonListViewModel
    var user: UserDetails
    
    init(viewModel: PersonListViewModel, user: UserDetails) {
        self.viewModel = viewModel
        self.user = user
        viewModel.onResult = { [weak self] result in
            switch result {
            case .navigationBack:
                self?.onResult?(.navigationBack)
            case .navigationDetail(user: let user):
                self?.onResult = nil
            }
        }
    }
}
