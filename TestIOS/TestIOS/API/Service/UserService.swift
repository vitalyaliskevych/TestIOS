//
//  UserDefaultService.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import Combine
import CryptoKit

class UserService {
    
    let networkRequestExecutor = NetworkRequestExecutor()
    private var cancellable: Set<AnyCancellable> = []
    
        func fetchPeople() -> AnyPublisher<[UserDetails], Error> {
            let url = URL(string: "http://opn-interview-service.nn.r.appspot.com/list")!
            let request = networkRequestExecutor.createRequest(for: url)
            return URLSession.shared.dataTaskPublisher(for: request)
                    .map { $0.data }
                    .decode(type: UsersList.self, decoder: JSONDecoder())
                    .flatMap {self.fetchUserDetails(userIds: $0.userIDs)}
                    .eraseToAnyPublisher()
        }
    
    private func fetchUserDetails(userIds: [String]) -> AnyPublisher <[UserDetails], Error> {
        let group = DispatchGroup()
        
        var arr = [UserDetails]()
        var lastError: Error?
        let result: Result<[UserDetails], Error>
        
        for id in userIds {
            group.enter()
            cancellable.insert(
                fetchPersonDetails(withId: id).sink { completion in
                    if case let .failure(error) = completion {
                        lastError = error
                    }
                    group.leave()
                } receiveValue: { userDetails in
                    arr.append(userDetails)
                }
            )
        }
        group.wait()
        if let lastError {
            result = .failure(lastError)
        } else {
            result = .success(arr)
        }
        return result.publisher.eraseToAnyPublisher()
    }
    
    private func fetchPersonDetails(withId id: String) -> AnyPublisher <UserDetails, Error> {
        let url = URL(string: "http://opn-interview-service.nn.r.appspot.com/get/\(id)")!
        let request = networkRequestExecutor.createRequest(for: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: UserDetailsResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
