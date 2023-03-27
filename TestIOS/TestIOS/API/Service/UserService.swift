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
    
    func fetchPeople() -> AnyPublisher<UsersList, Error> {
        
        let url = URL(string: "http://opn-interview-service.nn.r.appspot.com/list")!
        let request = networkRequestExecutor.createRequest(for: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: UsersList.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func fetchUserDetails(userIds: [String], completions: @escaping (AnyPublisher <[UserDetails], Error>) -> Void) {
        let group = DispatchGroup()
        
        var arr = [UserDetails]()
        var lastError: Error?
        var result: Result<[UserDetails], Error> = .success([])
        
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
        group.notify(queue: DispatchQueue.main) {
            if let lastError {
                result = .failure(lastError)
            } else {
                result = .success(arr)
            }
            completions(result.publisher.eraseToAnyPublisher())
        }
    }
    
    func fetchPersonDetails(withId id: String) -> AnyPublisher <UserDetails, Error> {
        let url = URL(string: "http://opn-interview-service.nn.r.appspot.com/get/\(id)")!
        let request = networkRequestExecutor.createRequest(for: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: UserDetailsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
