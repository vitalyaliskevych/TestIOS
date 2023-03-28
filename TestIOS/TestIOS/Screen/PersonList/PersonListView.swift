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
                        Button {
                            viewModel.navigationDetail(user: userDetails)
                        } label: {
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
            viewModel.userDetails.removeAll()
        }.alert(isPresented: $viewModel.isAlerting) {
            Alert(
                title: Text(viewModel.error?.localizedDescription ?? "retry"),
                dismissButton: .cancel(Text("retry")) {
                    viewModel.retry()
                }
            )
        }
    }
}
