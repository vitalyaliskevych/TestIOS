//
//  IntroViewModel.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import Combine

class PersonDetailViewModel: ObservableObject {
    
    var userService: UserService
    @Published var error: Error?
    @Published var userDetails = [UserDetails]()
    private var cancellable: AnyCancellable?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    enum Result {
        case navigationBack
    }
    
    var onResult: ((Result) -> Void)?
    
    func navigationBack() {
        onResult?(.navigationBack)
    }
}
