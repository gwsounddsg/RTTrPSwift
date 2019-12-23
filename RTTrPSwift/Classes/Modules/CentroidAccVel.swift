// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation





public struct CentroidAccVel: Packet, PositionAccelerationVelocity {
    // Packet
    public let type: RTTCode = .trackedPointAccVel
    public var size: uint16 = 0
    
    // Position
    public var position: Coordinates<Double>!
    
    // Acceleration and Velocity
    public var acceleration: Coordinates<Float>!
    public var velocity: Coordinates<Float>!
    
    
    public init(_ array: inout [UInt8]) throws {
        if array.count < PacketSize.centroidAccVel.rawValue {throw RTTError.byteCountTooSmallToInit(type)}
        try initForPosAccVelProtocol(&array)
    }
    
    
    public func print() {
        logging("======Centroid Acceleration/Velocity Module======", shiftRight: 3)
        
        logging("Module Size: \(size)", shiftRight: 3)
        
        logging("X Position: \(position.x.roundTo(2))", shiftRight: 3)
        logging("Y Position: \(position.y.roundTo(2))", shiftRight: 3)
        logging("Z Position: \(position.z.roundTo(2))", shiftRight: 3)
        
        logging("X Acceleration: \(acceleration.x.roundTo(2))", shiftRight: 3)
        logging("Y Acceleration: \(acceleration.y.roundTo(2))", shiftRight: 3)
        logging("Z Acceleration: \(acceleration.z.roundTo(2))", shiftRight: 3)
        
        logging("X Velocity: \(velocity.x.roundTo(2))", shiftRight: 3)
        logging("Y Velocity: \(velocity.y.roundTo(2))", shiftRight: 3)
        logging("Z Velocity: \(velocity.z.roundTo(2))", shiftRight: 3)
        
        logging("================================", shiftRight: 3)
    }
}
