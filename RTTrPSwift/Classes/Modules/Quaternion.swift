// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation





public struct Quaternion: Packet, Position {
    // Packet
    public let type: RTTCode = .orientationQuaternion
    public var size: uint16 = 0
    
    // Local
    public var latency: uint16 = 0
    public var position: Coordinates<Double>!
    public var w: Double = 0
    
    
    public init(_ array: inout [UInt8]) throws {
        if array.count < PacketSize.quaternion.rawValue {throw RTTError.byteCountTooSmallToInit(type)}
        
        // populates size and position
        latency = try initForPositionWithLatency(&array)
        
        // w - 8 bytes
        w = try Double([array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]])
        array.removeSubrange(0...7)
    }
    
    
    public func print() {
        logging("==================Quaternion Module==================", shiftRight: 3)
        
        logging("Module Size: \(size)", shiftRight: 3)
        logging("Latency: \(latency)", shiftRight: 3)
        logging("Qx: \(position.x.roundTo(2))", shiftRight: 3)
        logging("Qy: \(position.y.roundTo(2))", shiftRight: 3)
        logging("Qz: \(position.z.roundTo(2))", shiftRight: 3)
        logging("Qw: \(w.roundTo(2))", shiftRight: 3)
        
        logging("================================", shiftRight: 3)
    }
}
