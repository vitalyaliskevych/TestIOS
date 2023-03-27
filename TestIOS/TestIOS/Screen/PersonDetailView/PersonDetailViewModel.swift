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
    @Published var error: Error?
    private var cancellable: AnyCancellable?
    
    init(networkRequestExecutor: NetworkRequestExecutor) {
        self.networkRequestExecutor = networkRequestExecutor
    }
    
    enum Result {
         case navigationBackToList
         case navigationBack
     }

     var onResult: ((Result) -> Void)?
     
     func navigationBack() {
         onResult?(.navigationBackToList)
     }
     
     func navigationBackTO() {
         onResult?(.navigationBackToList)
     }
     
}


