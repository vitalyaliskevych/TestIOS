//
//  MainView.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject  var viewModel = MainViewModel()
    
    var usersList: some View {
        Group <#_#>{
            if viewModel.fetchedData {
                List(viewModel.details) { details in
                    NavigationLink {
//                        UserDetailsView(viewModel: UserDetailsViewModel(userDetails: details))
                    } label: {
                        Text(details.firstName)
                    }
                }
                .listStyle(GroupedListStyle())
                .refreshable {
                    viewModel.getUserID()
                }
            } else {
                if viewModel.errorMessage.isEmpty {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Text("Error occured :(")
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear(perform: {
            if !viewModel.fetchedData {
                self.viewModel.getUserID()
            }
        })
    }

    var body: some View {
        NavigationView {
            usersList
                .navigationTitle("Home")
                .alert(viewModel.error, isPresented: $viewModel.isShowing) {
                    Button("OK", role: .cancel) { }
                }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
