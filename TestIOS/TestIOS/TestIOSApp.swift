//
//  TestIOSApp.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import SwiftUI

@main
struct TestIOSApp: App {
    var body: some Scene {
        WindowGroup {
            CoordatatorAppView(coordinator: CoordinatorApp(viewModel: PersonListViewModel(userService: UserService())))
        }
    }
}
