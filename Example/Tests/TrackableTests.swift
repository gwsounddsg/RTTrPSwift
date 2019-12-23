// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import XCTest
import RTTrPSwift





class TrackableTests: XCTestCase {

    var trackable: Trackable!
    var trackableFull: Trackable!
    
    
    override func setUp() {
        var data = trackableData
        var fullData = trackableData + centroidAccVelData + trackedPointAccVelData + trackedPointAccVelData + trackedPointAccVelData
        
        do {
            trackable = try Trackable(&data)
            trackableFull = try Trackable(&fullData)
        }
        catch {
            // handeled in first test
        }
    }
}





extension TrackableTests {
    
    func testTrackable() {
        var data = trackableData
        
        do {
            trackable = try Trackable(&data)
            XCTAssertTrue(data.isEmpty)
        }
        catch {
            XCTAssert(false, "\(error)")
        }
    }
    
    
    func testTrackable_type() {
        XCTAssertEqual(trackable.type, .trackable)
    }
    
    
    func testTrackable_size() {
        XCTAssertEqual(trackable.size, 213)
    }
    
    
    func testTrackable_nameLength() {
        XCTAssertEqual(trackable.nameLength, 1)
    }
    
    
    func testTrackable_name() {
        XCTAssertEqual(trackable.name, "0")
    }
    
    
    func testTrackable_timestamp() {
        XCTAssertEqual(trackable.timestamp, 0)
    }
    
    
    func testTrackable_moduleCount() {
        XCTAssertEqual(trackable.moduleCount, 4)
    }
    
    
    func testTrackable_subModules() {
        XCTAssertEqual(trackableFull.submodules.count, 2)
    }
}
