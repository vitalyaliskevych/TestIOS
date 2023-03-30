//
//  IntroViewModel.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import Combine

class PersonDetailViewModel: ObservableObject {
    
    private let userService: UserServise
    @Published var error: Error?
    @Published var userDetails = [UserDetails]()
    private var cancellable: AnyCancellable?
    
    init(userService: UserServise) {
        self.userService = userService
    }
    
    enum Result: Equatable {
        case navigationBack
    }
    
    var onResult: ((Result) -> Void)?
    
    func navigationBack() {
        onResult?(.navigationBack)
    }
}
