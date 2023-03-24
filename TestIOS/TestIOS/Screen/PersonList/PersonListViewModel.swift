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
    private let networkRequestExecutor: NetworkRequestExecutor
    
    @Published var userDetails = [UserDetails]()
    @Published var error: LocalizedError?
    @Published var isAlerting = false
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(networkRequestExecutor: NetworkRequestExecutor) {
        self.networkRequestExecutor = networkRequestExecutor
    }
    
    func fetchPeople() {
        let url = URL(string: "http://opn-interview-service.nn.r.appspot.com/list")!
        let request = networkRequestExecutor.createRequest(for: url)
        
        cancellable.insert(
            URLSession.shared.dataTaskPublisher(for: request)
                .map { $0.data }
                .decode(type: UsersList.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self?.error = error as? LocalizedError
                        self?.isAlerting = true
                    }
                }, receiveValue: { [weak self] userDetails in
                    self?.fetchUserDetails(userIds: userDetails.userIDs)
                    self?.isAlerting = false
                }))
    }
    
    func fetchUserDetails(userIds: [String]) {
        let group = DispatchGroup()
        
        var arr = [UserDetails]()
        for id in userIds {
            group.enter()
            cancellable.insert(
                fetchPersonDetails(withId: id).sink { error in
                    group.leave()
                } receiveValue: { userDetails in
                    arr.append(userDetails)
                }
            )
        }
        group.notify(queue: .main) { [weak self] in
            self?.userDetails = arr
        }
    }
    
    func fetchPersonDetails(withId id: String) -> AnyPublisher <UserDetails, Error> {
        let url = URL(string: "http://opn-interview-service.nn.r.appspot.com/get/\(id)")!
        let request = networkRequestExecutor.createRequest(for: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: UserDetailsResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
