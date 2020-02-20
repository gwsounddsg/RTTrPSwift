// =================================================================
// Created by:  GW Rodriguez
// Date:        12/22/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import XCTest
import RTTrPSwift





class QuaternionTests: XCTestCase {

    var quaternion: Quaternion?
    
    
    override func setUp() {
        var data = quaternionData
        data.removeFirst()
        
        do {
            quaternion = try Quaternion(&data)
        }
        catch {
            // errors handled in first test
        }
    }
}





extension QuaternionTests {
    
    func testQuaternion() {
        var data = quaternionData
        data.removeFirst()
        
        do {
            _ = try Quaternion(&data)
            XCTAssertTrue(data.isEmpty)
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    
    func testQuaternion_size() {
        if quaternion == nil {XCTAssert(false); return}
        XCTAssertEqual(Int(quaternion!.size), PacketSize.quaternion.rawValue + 1)
    }
    
    
    func testQuaternion_latency() {
        XCTAssertEqual(quaternion?.latency, 1)
    }
    
    
    func testQuaternion_x() {
        if quaternion == nil {XCTAssert(false); return}
        XCTAssertEqual(quaternion!.position.x, 9.7888, accuracy: 0.0001)
    }
    
    
    func testQuaternion_y() {
        if quaternion == nil {XCTAssert(false); return}
        XCTAssertEqual(quaternion?.position.y, 0)
    }
    
    
    func testQuaternion_z() {
        if quaternion == nil {XCTAssert(false); return}
        XCTAssertEqual(quaternion!.position.z, 2.0647, accuracy: 0.0001)
    }
    
    
    func testQuaternion_w() {
        if quaternion == nil {XCTAssert(false); return}
        XCTAssertEqual(quaternion!.w, 9.7888, accuracy: 0.0001)
    }
}
