//
//  IntroViewModel.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import Combine

class IntroViewModel: ObservableObject {
    let id: String
    var cancellable: AnyCancellable?

    @Published var firstName: String = ""
    @Published var isUserDeleted: Bool = false

    var userDetails: UserDetails?
    
    init(id: String) {
        self.id = id
    }
}

final class IntroViewModelImpl: IntroViewModel {
    
    let usersService: UserDefaultService
    init(usersService: UserDefaultService) {
        self.usersService = usersService
    }
    
    func getUserDetails() {
        cancellable = usersService.getUserDetails(for: id).sink(receiveCompletion: { _ in }, receiveValue: { userDetails in
            if userDetails.status != "error" {
                self.userDetails = userDetails.data
                self.firstName = userDetails.data.firstName
                print(userDetails.data.firstName)
            } else {
                self.isUserDeleted = true
                print(self.id)
            }
        })
    }
}
