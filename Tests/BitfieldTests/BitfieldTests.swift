import XCTest
@testable import Bitfield

final class BitfieldTests: XCTestCase {
    func testSet() {
        let bitfield = Bitfield(size: 10)
        bitfield.set(atIndex: 0)
        bitfield.set(atIndex: 9)
        
        for index in 1..<9 {
            XCTAssertFalse(bitfield.isSet(atIndex: index))
        }
        
        XCTAssertTrue(bitfield.isSet(atIndex: 0))
        XCTAssertTrue(bitfield.isSet(atIndex: 9))
        XCTAssertNoThrow(bitfield.set(atIndex: 11))
        XCTAssertFalse(bitfield.isSet(atIndex: 11))
        XCTAssertEqual(bitfield.data, Data([0x80, 0x40]))
    }
    
    func testAssignData() {
        let bitfield = Bitfield(size: 10)
        bitfield.data = Data([0x80, 0x40])
    
        for index in 1..<9 {
            XCTAssertFalse(bitfield.isSet(atIndex: index))
        }
        
        XCTAssertTrue(bitfield.isSet(atIndex: 0))
        XCTAssertTrue(bitfield.isSet(atIndex: 9))
    }
    
    func testShouldDropExtraBytes() {
        let bitfield = Bitfield(size: 3)
        bitfield.data = Data([0x80, 0xfe, 0x40, 0xcf])
        
        XCTAssertTrue(bitfield.data.count == 1)
        XCTAssertTrue(bitfield.isSet(atIndex: 0))
        XCTAssertFalse(bitfield.isSet(atIndex: 1))
        XCTAssertFalse(bitfield.isSet(atIndex: 2))
    }
    
    func testDataShouldBeTheSameAfterManipulation() {
        let bitfield = Bitfield(size: 10)
        let originalData = Data([0x80, 0x40])
        bitfield.data = originalData
        
        bitfield.unset(atIndex: 0)
        bitfield.set(atIndex: 1)
        bitfield.set(atIndex: 2)
        bitfield.unset(atIndex: 9)
        
        bitfield.set(atIndex: 0)
        bitfield.set(atIndex: 9)
        bitfield.unset(atIndex: 1)
        bitfield.unset(atIndex: 2)
        
        XCTAssertEqual(bitfield.data, originalData)
    }

    static var allTests = [
        ("testSet", testSet),
        ("testAssignData", testAssignData),
        ("testShouldDropExtraBytes", testShouldDropExtraBytes),
        ("testDataShouldBeTheSameAfterManipulation", testDataShouldBeTheSameAfterManipulation),
    ]
}
