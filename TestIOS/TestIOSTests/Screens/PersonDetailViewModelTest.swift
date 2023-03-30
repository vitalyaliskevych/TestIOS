//
//  PersonDetailViewModelTest.swift
//  TestIOSTests
//
//  Created by Developer on 29.03.2023.
//

@testable import TestIOS
import XCTest

class PersonDetailViewModelTest: XCTestCase {
    
    func testOnTapButtonBack() {
        let sut = PersonDetailViewModel(userService: UserServiceMock())
        var result: PersonDetailViewModel.Result?
        sut.onResult = { value in
            result = value
        }
        sut.navigationBack()
        XCTAssertEqual(result, .navigationBack)
    }
}
