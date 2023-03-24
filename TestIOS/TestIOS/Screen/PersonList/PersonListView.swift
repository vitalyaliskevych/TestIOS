//
//  MainView.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import SwiftUI

struct PersonListView: View {
    
    @ObservedObject var viewModel: PersonListViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.isAlerting {
                Text(viewModel.error!.localizedDescription)
            } else {
                List(viewModel.userDetails) { userDetails in
                    NavigationLink(destination: PersonDetailView(userDetails: userDetails)) {
                        Text(userDetails.firstName)
                    }
                }.navigationTitle("People")
            }
        }.onAppear {
            viewModel.fetchPeople()
        }
    }
}
