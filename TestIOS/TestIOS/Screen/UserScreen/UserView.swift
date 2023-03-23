//
//  UserView.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("Name: \(viewModel.userDetails.firstName) \(viewModel.userDetails.lastName)")
            Text("Age: \(viewModel.userDetails.age)")
            Text("Gender: \(viewModel.userDetails.gender)")
            Text("Country: \(viewModel.userDetails.country)")
        }
        .navigationTitle("User's Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}
