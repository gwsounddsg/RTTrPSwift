// =================================================================
// Created by:  GW Rodriguez
// Date:        12/22/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import XCTest
import RTTrPSwift





class EulerTests: XCTestCase {

    var euler: Euler?
    
    override func setUp() {
        var data = eulerData
        data.removeFirst()
        
        do {
            euler = try Euler(&data)
        }
        catch {
            // error handled in first test
        }
    }
}





extension EulerTests {
    
    func testEuler() {
        var data = eulerData
        data.removeFirst()
        
        do {
            _ = try Euler(&data)
            XCTAssertTrue(data.isEmpty)
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    
    func testEuler_size() {
        if euler == nil {XCTAssert(false); return}
        XCTAssertEqual(Int(euler!.size), PacketSize.euler.rawValue + 1)
    }
    
    
    func testEuler_latency() {
        XCTAssertEqual(euler?.latency, 1)
    }
    
    
    func testEuler_order() {
        XCTAssertEqual(euler?.order, 2)
    }
    
    
    func testEuler_r1() {
        if euler == nil {XCTAssert(false); return}
        XCTAssertEqual(euler!.r1, 9.7888, accuracy: 0.0001)
    }
    
    
    func testEuler_r2() {
        XCTAssertEqual(euler?.r2, 0)
    }
    
    
    func testEuler_r3() {
        if euler == nil {XCTAssert(false); return}
        XCTAssertEqual(euler!.r3, 2.0647, accuracy: 0.0001)
    }
}
