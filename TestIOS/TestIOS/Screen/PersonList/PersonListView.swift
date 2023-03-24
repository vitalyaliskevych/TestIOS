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
            List(viewModel.people) { person in
                NavigationLink(destination: PersonDetailView(person: person)) {
                    Text(person.firstName)
                }
            }
            .navigationTitle("People")
        }
    }
}
