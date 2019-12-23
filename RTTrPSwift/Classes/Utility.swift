// =================================================================
// Created by:  GW Rodriguez
// Date:        12/19/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation





/// Prints with formatted tabbing if LOGGING true
func logging(_ msg: String, shiftRight: Int = 0) {
    if LOGGING {
        var shift = shiftRight
        while shift > 0 {
            print("|\t", terminator: "")
            shift -= 1
        }
        print(msg)
    }
}





/**
 - This function takes in an array of UInt8's and returns a single integer combining the array.
 - Example result from [0x00, 0x00, 0x00, 0x01] == UInt32(1), [0xFF, 0xFF] == UInt16(65535)
 - Returns optional because you could pass only 3 bytes for a UInt32 which wouldn't work
 
 ## Usage
 - let val: UInt32? = integerWithBytes([0x32, 0x51, 0x00, 0x09])
 
 - Parameter bytes: An array of UInt8's
*/
func integerWithBytes<T: BinaryInteger> (_ bytes: [UInt8]) throws -> T {
    if bytes.count != MemoryLayout<T>.size {throw RTTError.badByteCountForReturnType}
    
    var result: T = 0
    for byte in bytes {
        result = result << 8 | T(byte)
    }
    
    return result
}





extension FloatingPoint {
    /**
    - This init takes in an array of UInt8's and returns a FloatingPoint type combining the array.
    - Returns optional because you could pass only 3 bytes for a Float which wouldn't work
    
    ## Usage
    - let val = Float([0x32, 0x51, 0x00, 0x09])
    
    - Parameter bytes: An array of UInt8's
    */
    init(_ bytes: [UInt8]) throws {
        guard bytes.count == MemoryLayout<Self>.size else {
            throw RTTError.badByteCountForReturnType
        }
        
        self = bytes.withUnsafeBytes {
            return $0.load(fromByteOffset: 0, as: Self.self)
        }
    }
}





/*
 The two extensions below are purely for printing purposes
 */
extension Double {
    func roundTo(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Float {
    func roundTo(_ places: Int) -> Float {
        let divisor = powf(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
