// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import XCTest
import RTTrPSwift





class CentroidAccVelTests: XCTestCase {

    var module: CentroidAccVel!
    
    
    override func setUp() {
        do {
            var data = centroidAccVelData
            data.removeFirst()
            module = try CentroidAccVel(&data)
        }
        catch {
            // checked in first test
        }
    }
}





extension CentroidAccVelTests {
    
    func testCentroidAccVel() {
        var data = centroidAccVelData
        data.removeFirst()
        
        do {
            _ = try CentroidAccVel(&data)
            XCTAssertTrue(data.isEmpty)
        }
        catch {
            XCTAssert(false, "\(error)")
        }
    }
    
    
    func testCentroidAccVel_size() {
        XCTAssertEqual(module.size, 51)
    }
    
    
    func testCentroidAccVel_x() {
        XCTAssertEqual(module.position.x, 9.788, accuracy: 0.001)
    }
    
    
    func testCentroidAccVel_y() {
        XCTAssertEqual(module.position.y, 0.0)
    }
    
    
    func testCentroidAccVel_z() {
        XCTAssertEqual(module.position.z, 2.064, accuracy: 0.001)
    }
    
    
    func testCentroidAccVel_accx() {
        XCTAssertEqual(module.acceleration.x, -109.643, accuracy: 0.001)
    }
    
    
    func testCentroidAccVel_accy() {
        XCTAssertEqual(module.acceleration.y, 0.0)
    }
    
    
    func testCentroidAccVel_accz() {
        XCTAssertEqual(module.acceleration.z, -53.164, accuracy: 0.001)
    }
    
    
    func testCentroidAccVel_velx() {
        XCTAssertEqual(module.velocity.x, 7.649, accuracy: 0.001)
    }
    
    
    func testCentroidAccVel_vely() {
        XCTAssertEqual(module.velocity.y, 0.0)
    }
    
    
    func testCentroidAccVel_velz() {
        XCTAssertEqual(module.velocity.z, -35.083, accuracy: 0.001)
    }
}
