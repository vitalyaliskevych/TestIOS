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
    private let userService: UserServise
    
    @Published var userDetails = [UserDetails]()
    @Published var error: Error?
    @Published var isAlerting = false
    @Published var isError = false
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(userService: UserServise) {
        self.userService = userService
    }
    
    enum Result: Equatable {
        case navigationDetail(user: UserDetails)
        case navigationBack
    }
    
    var onResult:((Result) -> Void)?
    
    func navigationDetail(user: UserDetails) {
        onResult?(.navigationDetail(user: user))
    }
    
    func fetchPeople() {
        let group = DispatchGroup()
        
        userService.fetchPeople().sink { [weak self] completion in
            if case let .failure(error) = completion {
                self?.error = error
                self?.isAlerting = true
            }
        } receiveValue: { [weak self] usersList in
            for id in (usersList.userIDs) {
                self?.fetchPersonDetail(id: id)
            }
            self?.isAlerting = false
        }.store(in: &cancellable)
        group.notify(queue: .main) {
            self.isError = true
        }
    }
    
    func retry() {
        userDetails = []
        error = nil
        fetchPeople()
        isError = true
    }
    
    func fetchPersonDetail(id: String) {
        userService.fetchPersonDetails(withId: id).sink { _ in
        } receiveValue: { [weak self] details in
            self?.userDetails.append(details)
        }.store(in: &cancellable)
    }
}
