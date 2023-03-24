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
    
    var cancellables: Set<AnyCancellable?> = []
}

final class MainViewModelImpl: MainViewModel {
    
    private let userService: UserDefaultService
    private let detailService: DetailService
    
    init(userService: UserDefaultService, detailService: DetailService, cancellables: Set<AnyCancellable?> = []) {
        self.userService = userService
        self.detailService = detailService
    }
    
    func getUserID() {
        cancellables = userService.getUsers()
            .mapError({ [weak self] (error) -> Error in
                self?.error = error.localizedDescription
                self?.isShowing = true
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] users in
                self?.id = users.userID.filter { UUID(uuidString: $0) != nil }
                self?.getUserDetails()
            })
    }
    
    private func getUserDetails() {
        let group = DispatchGroup()

        for id in id {
            group.enter()
            cancellables.insert(detailService.getDetails(for: id)
                                    .sink(receiveCompletion: { _ in
                group.leave()
            }, receiveValue: { [weak self] detailService in
                if let self = self, !self.detailService.contains(where: { $0 == detailService.data }) {
                    self.detailService.append(detailService.data)
                }
            }))
        }
        group.notify(queue: .main) {
            self.fetchedData = true
        }
    }
}
