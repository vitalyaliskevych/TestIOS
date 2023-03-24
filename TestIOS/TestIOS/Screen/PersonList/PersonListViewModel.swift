//
//  MainViewModel.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import Combine
import Network

class PersonListViewModel: ObservableObject {
    private var userService: UserService
    
    @Published var userDetails = [UserDetails]()
    @Published var error: Error?
    @Published var isAlerting = false
    
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func fetchPeople() {
        userService.fetchPeople().sink { [weak self] completion in
            if case let .failure(error) = completion {
                self?.error = error
                self?.isAlerting = true
            }
        } receiveValue: { [weak self] userDetails in
            self?.userDetails = userDetails
            self?.isAlerting = false
        }.store(in: &cancellable)
    }
}
