//
//  UserDefaultService.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import Combine
import CryptoKit

protocol UserDefaultService {
    
    func getUsers() -> AnyPublisher<UsersList, Error>
}

final class UsersService {
    
    private var token: String = ""
    let executor: NetworkRequestExecutor
    
    init(token: String, executor: NetworkRequestExecutor) {
        self.token = token
        self.executor = executor
    }

    func getUsers() -> AnyPublisher<UsersList, Error> {
        guard let url = URL(string: "https://opn-interview-service.nn.r.appspot.com/list") else {
            fatalError("Cannot create url")
        }
        
        let request = executor.createRequest(for: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: UsersList.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
