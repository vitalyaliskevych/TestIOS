//
//  UserViewModel.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import Combine

class UserViewModel: ObservableObject, Identifiable {
    let userDetails: UserDetails
    
    init(userDetails: UserDetails) {
        self.userDetails = userDetails
    }
}
