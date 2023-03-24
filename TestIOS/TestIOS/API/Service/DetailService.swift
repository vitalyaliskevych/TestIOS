//
//  DetailService.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import SwiftUI
import Combine

protocol DetailService {
    
    func getDetails(for id: String) -> AnyPublisher<UserDetailsResponse, Error>
}

final class DetailServiceImpl: DetailService {
    
    let executor: NetworkRequestExecutor
    
    init(executor: NetworkRequestExecutor) {
        self.executor = executor
    }
    
    func getDetails(for id: String) -> AnyPublisher<UserDetailsResponse, Error> {
        guard let url = URL(string: "https://opn-interview-service.nn.r.appspot.com/get/\(id)") else {
            fatalError("Cannot create url")
        }
        
        let request = executor.createRequest(for: url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: UserDetailsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
