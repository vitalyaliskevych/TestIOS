//
//  IntroView.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import SwiftUI

struct PersonDetailView: View {
    
    @ObservedObject var viewModel: PersonDetailViewModel
    let userDetails: UserDetails
    
    var body: some View {
        ZStack {
            VStack {
                Text(userDetails.firstName)
                Text(userDetails.lastName)
                Text("\(userDetails.age)")
                Text(userDetails.gender)
                Text(userDetails.country)
                Spacer()
                Button {
                    viewModel.navigationBackTO()
                } label: {
                Text("Back")
                }

            }
            .foregroundColor(.red)
            .font(.system(size: 25))
        }
    }
}
