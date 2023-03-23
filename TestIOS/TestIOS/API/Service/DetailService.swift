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
    
}

final class DetailServiceImpl: DetailService {
    
    let executor: NetworkRequestExecutor
    
    init(executor: NetworkRequestExecutor) {
        self.executor = executor
    }
}
