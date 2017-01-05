//
//  HotelsCollectionViewControllerTests.swift
//  Tajawal
//
//  Created by Aleksei Neronov on 05.01.17.
//  Copyright © 2017 Aleksei Neronov. All rights reserved.
//

import XCTest
@testable import Tajawal

class HotelsCollectionViewControllerTests: XCTestCase {
    
    var viewController: HotelsCollectionViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HotelsCollectionViewController") as! HotelsCollectionViewController
    }

    func testCollectionView() {
        XCTAssertNotNil(viewController.collectionView)
        REST.loadHotels { (hotels) in
            REST.hotels = hotels
            XCTAssertTrue((REST.hotels?.count)! > 0)            
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        viewController = nil
    }
    
    
}
