//
//  MainViewModel.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import Combine
import Network

class MainViewModel: ObservableObject {
    
    @Published var fetchedData = false
    @Published var isShowing = false
    @Published var error = ""

    @Published var id: [String] = []
    @Published var details = [UserDetails]()
}

final class MainViewModelImpl: MainViewModel {
    
    private let userService: UserDefaultService
    private var cancellables = Set<AnyCancellable>()
    
    init(userService: UserDefaultService, cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.userService = userService
        self.cancellables = cancellables
    }
    
    func getUserID() {
        cancellables = usersService.getUsers()
            .mapError({ [weak self] (error) -> Error in
                self?.error = error.localizedDescription
                self?.isShowing = true
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] users in
                self?.ids = users.userIDs.filter { UUID(uuidString: $0) != nil }
                self?.fetchUserDetails()
            })
    }
    
    private func getUserDetails() {
        let group = DispatchGroup()

        for id in id {
            group.enter()
            cancellables.insert(usersService.getUserDetails(for: id)
                                    .sink(receiveCompletion: { _ in
                group.leave()
            }, receiveValue: { [weak self] userDetails in
                if let self = self, !self.details.contains(where: { $0 == userDetails.data }) {
                    self.details.append(userDetails.data)
                }
            }))
        }
        group.notify(queue: .main) {
            self.fetchedData = true
        }
    }
}
