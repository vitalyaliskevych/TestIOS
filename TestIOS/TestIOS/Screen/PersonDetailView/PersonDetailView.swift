//
//  IntroView.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import SwiftUI

struct PersonDetailView: View {
    
    let userDetails: UserDetails
    
    var body: some View {
        VStack {
            Text(userDetails.firstName)
            Text(userDetails.lastName)
            Text("\(userDetails.age)")
            Text(userDetails.gender)
            Text(userDetails.country)
        }
    }
}
