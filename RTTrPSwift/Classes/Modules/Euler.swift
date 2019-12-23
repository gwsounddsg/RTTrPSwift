// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation





public struct Euler: Packet {
    // Packet
    public let type: RTTCode = .orientationEuler
    public var size: uint16
    
    // Local
    public let latency: uint16
    public let order: uint16
    public let r1, r2, r3: Double
    
    
    public init(_ array: inout [UInt8]) throws {
        if array.count < PacketSize.euler.rawValue {throw RTTError.byteCountTooSmallToInit(type)}
        
        // size - 2 bytes
        size = try integerWithBytes([array[0], array[1]])
        array.removeSubrange(0...1)
        
        // latency - 2 bytes
        latency = try integerWithBytes([array[0], array[1]])
        array.removeSubrange(0...1)
        
        // order - 2 bytes
        order = try integerWithBytes([array[0], array[1]])
        array.removeSubrange(0...1)
        
        // r1 - 8 bytes
        r1 = try Double([array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]])
        array.removeSubrange(0...7)
        
        // r2 - 8 bytes
        r2 = try Double([array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]])
        array.removeSubrange(0...7)
        
        // r3 - 8 bytes
        r3 = try Double([array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]])
        array.removeSubrange(0...7)
    }
    
    
    public func print() {
        logging("==================Euler Module==================", shiftRight: 3)
        
        logging("Module Size: \(size)", shiftRight: 3)
        logging("Latency: \(latency)", shiftRight: 3)
        logging("Euler Order: \(order)", shiftRight: 3)
        logging("R1: \(r1.roundTo(2))", shiftRight: 3)
        logging("R2: \(r2.roundTo(2))", shiftRight: 3)
        logging("R3: \(r3.roundTo(2))", shiftRight: 3)
        
        logging("================================", shiftRight: 3)
    }
}
