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
    @Published var error = false
    private var cancellable: AnyCancellable?
    
    init(networkRequestExecutor: NetworkRequestExecutor) {
        self.networkRequestExecutor = networkRequestExecutor
    }
    
    func fetchPeople() {
        let url = URL(string: "http://opn-interview-service.nn.r.appspot.com/list")!
        let request = networkRequestExecutor.createRequest(for: url)
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: userDetails.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                }
            }, receiveValue: { [weak self] error in
                self?.error = error
            })
    }
}
