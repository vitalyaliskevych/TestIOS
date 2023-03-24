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
            List(viewModel.userDetails) { userDetails in
                NavigationLink(destination: PersonDetailView(userDetails: userDetails)) {
                    Text(userDetails.firstName)
                }
            }
            .navigationTitle("People")
//        }.alert(isPresented: $viewModel.isAlerting, error: viewModel.error) {
//            Button {
//                {}
//            } label: {
//                Text("Ok")
//            }
//
        }.onAppear {
            viewModel.fetchPeople()
        }
    }
}
