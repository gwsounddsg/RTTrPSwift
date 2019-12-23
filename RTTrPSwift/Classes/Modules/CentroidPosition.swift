// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation





public struct CentroidPosition: Position {
    // Packet
    public let type: RTTCode = .centroidPosition
    public var size: uint16 = 0
    
    // Local
    public var latency: uint16 = 0
    public var position: Coordinates<Double>!
    
    
    public init(_ array: inout [UInt8]) throws {
        if array.count < PacketSize.centroidPosition.rawValue {throw RTTError.byteCountTooSmallToInit(type)}
        latency = try initForPositionWithLatency(&array)
    }
    
    
    public func print() {
        logging("==================Centroid Module==================", shiftRight: 3)
        
        logging("Module Size: \(size)", shiftRight: 3)
        logging("Latency: \(latency)", shiftRight: 3)
        logging("X Position: \(position.x.roundTo(2))", shiftRight: 3)
        logging("Y Position: \(position.y.roundTo(2))", shiftRight: 3)
        logging("Z Position: \(position.z.roundTo(2))", shiftRight: 3)
        
        logging("================================", shiftRight: 3)
    }
}
