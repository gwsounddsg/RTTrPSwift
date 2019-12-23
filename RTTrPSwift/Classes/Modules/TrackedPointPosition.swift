// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation





public struct TrackedPointPosition: Position {
    // Packet
    public let type: RTTCode = .trackedPointPosition
    public var size: uint16 = 0
    
    // Local
    public var latency: uint16 = 0
    public var position: Coordinates<Double>!
    public var index: uint8 = 0
    
    
    public init(_ array: inout [UInt8]) throws {
        if array.count < PacketSize.trackedPointPosition.rawValue {throw RTTError.byteCountTooSmallToInit(type)}
        
        // inits size and position
        latency = try initForPositionWithLatency(&array)
        
        // index - 1 byte
        index = array[0]
        array.removeFirst()
    }
    
    
    public func print() {
        logging("==================TrackedPoint Module==================", shiftRight: 3)
        
        logging("Module Size: \(size)", shiftRight: 3)
        logging("Latency: \(latency)", shiftRight: 3)
        logging("X Position: \(position.x.roundTo(2))", shiftRight: 3)
        logging("Y Position: \(position.y.roundTo(2))", shiftRight: 3)
        logging("Z Position: \(position.z.roundTo(2))", shiftRight: 3)
        logging("LED Index: \(index)", shiftRight: 3)
        
        logging("================================", shiftRight: 3)
    }
}
