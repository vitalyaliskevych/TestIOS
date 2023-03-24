//
//  IntroView.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import SwiftUI

struct PersonDetailView: View {
    
    let person: Person
    
    var body: some View {
        VStack {
            Text(person.firstName)
            Text(person.lastName)
            Text("\(person.age)")
            Text(person.gender.rawValue)
            Text(person.country)
        }
    }
}
