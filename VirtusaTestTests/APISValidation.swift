//
//  APISValidation.swift
//  VirtusaTestTests
//
//  Created by Apple on 22/03/22.
//

import XCTest

@testable import VirtusaTest

class APISValidation: XCTestCase {
    
    
    var peopleList = [People]()
    var roomsList  = [Rooms]()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func test_people_api_with_proper_data(){
        
        let expectation = expectation(description: "People API Test")


        let URL =  NSURL(string:kBaseURL + kPeople)
        let request = RequestModelForGet(url:URL!,querryItems: nil,httpHeaderField: nil, httpHeaderField_userInputContent: nil)
        APIWapperClass.ServicerequestForGetMethod(request, [People].self) { result,response in
            
            switch result {
            case .success(let model):
            self.peopleList = model
                                
            XCTAssertNotNil(self.peopleList)
            XCTAssert(response.statusCode == 200)
            XCTAssertEqual(200, response.statusCode)
            expectation.fulfill()
               
            case .failure(let error):
                print("Error  = > ", error.localizedDescription.debugDescription)
            }
        }
        
        waitForExpectations(timeout: 5){ error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
            }
         }
      }
    
    func test_people_api_with_wrong_data(){
        
        let expectation = expectation(description: "People API Test")


        let URL =  NSURL(string:kBaseURL + "peoples")
        let request = RequestModelForGet(url:URL!,querryItems: nil,httpHeaderField: nil, httpHeaderField_userInputContent: nil)
        APIWapperClass.ServicerequestForGetMethod(request, [People].self) { result,response  in
            
            XCTAssertNotEqual(response.statusCode, 200)
            XCTAssert(response.statusCode == 404)
            XCTAssertEqual(404, response.statusCode)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5){ error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
            }
         }
      }
    
 
    func test_rooms_api_with_proper_data(){
        
        let expectation = expectation(description: "Rooms API Test")


        let URL =  NSURL(string:kBaseURL + kRooms)
        let request = RequestModelForGet(url:URL!,querryItems: nil,httpHeaderField: nil, httpHeaderField_userInputContent: nil)
        APIWapperClass.ServicerequestForGetMethod(request, [Rooms].self) { result,response in
            
            switch result {
            case .success(let model):
            self.roomsList = model
                                
            XCTAssertNotNil(self.roomsList)
            XCTAssert(response.statusCode == 200)
            XCTAssertEqual(200, response.statusCode)
            expectation.fulfill()
               
            case .failure(let error):
                print("Error  = > ", error.localizedDescription.debugDescription)
            }
        }
        
        waitForExpectations(timeout: 5){ error in
                if let error = error {
                print("Error: \(error.localizedDescription)")
            }
         }
      }
    
    func test_rooms_api_with_wrong_data(){
        
        let expectation = expectation(description: "Rooms API Test")

        let URL =  NSURL(string:kBaseURL + "roomss")
        let request = RequestModelForGet(url:URL!,querryItems: nil,httpHeaderField: nil, httpHeaderField_userInputContent: nil)
        APIWapperClass.ServicerequestForGetMethod(request, [Rooms].self) { result,response  in
            
            XCTAssertNotEqual(response.statusCode, 200)
            XCTAssert(response.statusCode == 404)
            XCTAssertEqual(404, response.statusCode)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5){ error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
            }
         }
      }


}

