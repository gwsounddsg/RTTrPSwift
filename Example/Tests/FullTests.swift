// ==================================================================
// Created by:  GW Rodriguez
// Date:        1/14/20
// Swift:       5.0
// Copyright:   Copyright © 2020 CocoaPods. All rights reserved.
// ==================================================================

import XCTest
import RTTrPSwift


class FullTests: XCTestCase {}





extension FullTests {
    
    func testFullTests_onePacket() {
        do {
            let data = Data(rttData)
            _ = try RTTrP(data: data.bytes)
        }
        catch {
            XCTAssert(false, error.localizedDescription)
        }
    }
}
