// =================================================================
// Created by:  GW Rodriguez
// Date:        12/22/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import XCTest
import RTTrPSwift





class CentroidPositionTests: XCTestCase {
    
    var centroid: CentroidPosition?
    
    
    override func setUp() {
        var data = centroidPositionData
        data.removeFirst()
        
        do {
            centroid = try CentroidPosition(&data)
        }
        catch {
            // handeled in first test
        }
    }
}





extension CentroidPositionTests {
    
    func testCentroidPosition() {
        var data = centroidPositionData
        data.removeFirst()
        
        do {
            _ = try CentroidPosition(&data)
            XCTAssertTrue(data.isEmpty)
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
    
    
    func testCentroidPosition_size() {
        if centroid == nil {XCTAssert(false); return}
        XCTAssertEqual(Int(centroid!.size), PacketSize.centroidPosition.rawValue + 1)
    }
    
    
    func testCentroidPosition_latency() {
        XCTAssertEqual(centroid?.latency, 1)
    }
    
    
    func testCentroidPosition_x() {
        if centroid == nil {XCTAssert(false); return}
        XCTAssertEqual(centroid!.position.x, 9.7888, accuracy: 0.0001)
    }
    
    
    func testCentroidPosition_y() {
        if centroid == nil {XCTAssert(false); return}
        XCTAssertEqual(centroid!.position.y, 2.0647, accuracy: 0.0001)
    }
    
    
    func testCentroidPosition_z() {
        XCTAssertEqual(centroid?.position.z, 0)
    }
}
