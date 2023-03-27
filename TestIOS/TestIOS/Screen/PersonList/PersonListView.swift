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
            if viewModel.isError {
                List {
                    ForEach(viewModel.userDetails, id: \.self) { userDetails in
                        NavigationLink(destination: PersonDetailView(userDetails: userDetails)) {
                            Text(userDetails.firstName)
                        }
                    }.navigationTitle("People")
                }
            } else {
                Text("Not Found data")
                    .foregroundColor(.gray)
                    .font(.system(size: 36))
            }
        }.onAppear {
            viewModel.fetchPeople()
        }.alert(isPresented: $viewModel.isAlerting) {
            Alert(
                title: Text(viewModel.error?.localizedDescription ?? "retry"),
                dismissButton: .default(Text("retry")) {
                    viewModel.retry()
                }
            )
        }
    }
}
