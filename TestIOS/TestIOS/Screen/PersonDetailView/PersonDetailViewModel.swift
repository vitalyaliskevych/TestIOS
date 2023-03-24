//
//  IntroViewModel.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import Combine

class PersonDetailViewModel: ObservableObject {
    
    private let networkRequestExecutor: NetworkRequestExecutor
    
    @Published var userDetails: UserDetails?
    @Published var error = false
    private var cancellable: AnyCancellable?
    
    init(networkRequestExecutor: NetworkRequestExecutor) {
        self.networkRequestExecutor = networkRequestExecutor
    }
    
    func fetchPersonDetails(withId id: String) {
        let url = URL(string: "http://opn-interview-service.nn.r.appspot.com/get/\(id)")!
        let request = networkRequestExecutor.createRequest(for: url)
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: userDetails.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error.encode(to: JSONEncoder())
                }
            }, receiveValue: { [weak self] userDetails in
                self?.userDetails = userDetails
            })
    }
}


