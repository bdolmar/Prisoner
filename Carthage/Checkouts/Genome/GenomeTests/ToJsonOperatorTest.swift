//
//  ToJsonOperatorTest.swift
//  Genome
//
//  Created by Logan Wright on 9/23/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import XCTest
@testable import Genome

class ToJsonOperatorTest: XCTestCase {
    
    struct Employee: BasicMappable, Hashable {
        
        var name: String = ""
        
        mutating func sequence(map: Map) throws -> Void {
            try name <~> map["name"]
        }
        
        var hashValue: Int {
            return name.hashValue
        }
        
    }
    
    struct Business: StandardMappable {
        
        let name: String
        let foundedYear: Int
        
        let locations: [String]
        let locationsOptional: [String]?
        
        let owner: Employee
        let ownerOptional: Employee?
        
        let employees: [Employee]
        let employeesOptional: [Employee]?
        
        let employeesArray: [[Employee]]
        let employeesOptionalArray: [[Employee]]?
        
        let employeesDictionary: [String : Employee]
        let employeesOptionalDictionary: [String : Employee]?
        
        let employeesDictionaryArray: [String : [Employee]]
        let employeesOptionalDictionaryArray: [String : [Employee]]?
        
        let employeesSet: Set<Employee>
        let employeesOptionalSet: Set<Employee>?
        
        var optionalNil: String?
        var optionalNotNil: String? = "not nil"
        
        init(map: Map) {
            name = try! <~map["name"]
            foundedYear = try! <~map["founded_in"]
            
            locations = try! <~map["locations"]
            locationsOptional = try! <~?map["locations"]
            
            owner = try! <~map["owner"]
            ownerOptional = try! <~?map["owner"]
            
            employees = try! <~map["employees"]
            employeesOptional = try! <~?map["employees"]
            
            employeesArray = try! <~map["employeesArray"]
            employeesOptionalArray = try! <~?map["employeesArray"]
            
            employeesDictionary = try! <~map["employeesDictionary"]
            employeesOptionalDictionary = try! <~?map["employeesDictionary"]
            
            employeesDictionaryArray = try! <~map["employeesDictionaryArray"]
            employeesOptionalDictionaryArray = try! <~?map["employeesDictionaryArray"]
            
            employeesSet = try! <~map["employees"]
            employeesOptionalSet = try! <~?map["employees"]
        }
        
        mutating func sequence(map: Map) throws -> Void {
            try name ~> map["name"]
            try foundedYear ~> map["foundedYear"]
            
            try locations ~> map["locations"]
            try locationsOptional ~> map["locationsOptional"]
            
            try owner ~> map["owner"]
            try ownerOptional ~> map["ownerOptional"]
            
            try employees ~> map["employees"]
            try employeesOptional ~> map["employeesOptional"]
            
            try employeesArray ~> map["employeesArray"]
            try employeesOptionalArray ~> map["employeesOptionalArray"]
            
            try employeesDictionary ~> map["employeesDictionary"]
            try employeesOptionalDictionary ~> map["employeesOptionalDictionary"]
            
            try employeesDictionaryArray ~> map["employeesDictionaryArray"]
            try employeesOptionalDictionaryArray ~> map["employeesOptionalDictionaryArray"]
            
            try employeesSet ~> map["employeesSet"]
            try employeesOptionalSet ~> map["employeesOptionalSet"]
            
            try optionalNil ~> map["optionalNil"]
            try optionalNotNil ~> map["optionalNotNil"]
        }
    }
    
    let locations = [
        "123 Street",
        "456 Road"
    ]
    
    let employees = [
        ["name" : "Joe"],
        ["name" : "Jane"],
        ["name" : "Joe"],
        ["name" : "Justin"]
    ]
    
    let employeesArray = [
        [["name" : "Joe"], ["name" : "Jane"]],
        [["name" : "Joe"], ["name" : "Justin"]]
    ]
    
    let employeesDictionary = [
        "0" : ["name" : "Joe"],
        "1" : ["name" : "Jane"]
    ]
    
    let employeesDictionaryArray = [
        "0" : [["name" : "Joe"], ["name" : "Phil"]],
        "1" : [["name" : "Jane"]]
    ]
    
    let employeesSet = [
        ["name" : "Joe"],
        ["name" : "Jane"],
        ["name" : "Justin"]
    ]
    
    let owner = [
        "name" : "Owner"
    ]
    
    lazy var businessJson: JSON = [
        "owner" : self.owner,
        "name" : "Good Business",
        "founded_in" : 1987,
        "locations" : self.locations,
        "employees" : self.employees,
        "employeesArray" : self.employeesArray,
        "employeesDictionary" : self.employeesDictionary,
        "employeesDictionaryArray" : self.employeesDictionaryArray,
        "employeesSet" : self.employeesSet
    ]
    
    lazy var goodBusiness: Business = try! Business.mappedInstance(self.businessJson)
    
    func test() {
        let json = try! goodBusiness.jsonRepresentation()
        
        // Basic type
        let name = json["name"] as! String
        XCTAssert(name == "Good Business")
        let foundedYear = json["foundedYear"] as! Int
        XCTAssert(foundedYear == 1987)
        
        // Basic type array
        let locations = json["locations"] as! [String]
        XCTAssert(locations == self.locations)
        let locationsOptional = json["locationsOptional"] as! [String]
        XCTAssert(locationsOptional == self.locations)
        
        // Mappable
        let owner = json["owner"] as! [String : String]
        XCTAssert(owner == self.owner)
        let ownerOptional = json["ownerOptional"] as! [String : String]
        XCTAssert(ownerOptional == self.owner)
        
        // Mappable array
        let employees = json["employees"] as! [[String : String]]
        XCTAssert(employees == self.employees)
        let employeesOptional = json["employeesOptional"] as! [[String : String]]
        XCTAssert(employeesOptional == self.employees)
        
        // Mappable array of arrays
        let employeesArray = json["employeesArray"] as! [[[String : String]]]
        XCTAssert(employeesArray[0] == self.employeesArray[0])
        XCTAssert(employeesArray[1] == self.employeesArray[1])
        let employeesOptionalArray = json["employeesOptionalArray"] as! [[[String : String]]]
        XCTAssert(employeesOptionalArray[0] == self.employeesArray[0])
        XCTAssert(employeesOptionalArray[1] == self.employeesArray[1])
        
        // Mappable dictionary
        let employeesDictionary = json["employeesDictionary"] as! [String : [String : String]]
        XCTAssert(employeesDictionary["0"]! == self.employeesDictionary["0"]!)
        XCTAssert(employeesDictionary["1"]! == self.employeesDictionary["1"]!)
        let employeesOptionalDictionary = json["employeesOptionalDictionary"] as! [String : [String : String]]
        XCTAssert(employeesOptionalDictionary["0"]! == self.employeesDictionary["0"]!)
        XCTAssert(employeesOptionalDictionary["1"]! == self.employeesDictionary["1"]!)
        
        // Mappable dictionary array
        let employeesDictionaryArray = json["employeesDictionaryArray"] as! [String : [[String : String]]]
        XCTAssert(employeesDictionaryArray["0"]! == self.employeesDictionaryArray["0"]!)
        XCTAssert(employeesDictionaryArray["1"]! == self.employeesDictionaryArray["1"]!)
        let employeesOptionalDictionaryArray = json["employeesOptionalDictionaryArray"] as! [String : [[String : String]]]
        XCTAssert(employeesOptionalDictionaryArray["0"]! == self.employeesDictionaryArray["0"]!)
        XCTAssert(employeesOptionalDictionaryArray["1"]! == self.employeesDictionaryArray["1"]!)
        
        // Mappable set
        let employeesSet = json["employeesSet"] as! [[String : String]]
        XCTAssert(employeesSet == self.employeesSet)
        let employeesOptionalSet = json["employeesOptionalSet"] as! [[String : String]]
        XCTAssert(employeesOptionalSet == self.employeesSet)
        
        // Nil
        let optionalNil = json["optionalNil"]
        XCTAssert(optionalNil == nil)
        let optionalNotNil = json["optionalNotNil"]
        XCTAssert(optionalNotNil != nil)
    }
    
}

// MARK: Operators

func ==(lhs: ToJsonOperatorTest.Employee, rhs: ToJsonOperatorTest.Employee) -> Bool {
    return lhs.name == rhs.name
}
