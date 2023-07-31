//
//  HomeViewModelTests.swift
//  PazaramaCloneAppTests
//
//  Created by bora ateş on 30.07.2023.
//

import XCTest
@testable import PazaramaCloneApp

final class HomeViewModelTests: XCTestCase {
    
    private var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = HomeViewModel()
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        
    }
    
    func test_fetch_homeProducts() {

        XCTAssertNil(viewModel.productsArray)
        
        viewModel.fetchDatas()
        
        XCTAssertNotNil(viewModel.productsArray)
        
        
    }
    
}
