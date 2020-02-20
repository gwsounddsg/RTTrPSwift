// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation





//MARK: - Protocols
public protocol Packet {
    var type: RTTCode {get}
    var size: uint16 {get set}
    
    init(_ array: inout [UInt8]) throws
    func print()
}





public protocol Position: Packet {
    var position: Coordinates<Double>! {get set}
}


extension Position {
    
    /// Used to init size and position. Owner must check for proper array size
    mutating func initForPosition(_ array: inout [UInt8]) throws {
        // size - 2 bytes
        size = try integerWithBytes([array[0], array[1]])
        array.removeSubrange(0...1)
        
        // X - 8 bytes
        let x = try Double([array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]])
        array.removeSubrange(0...7)
        
        // y - 8 bytes
        let y = try Double([array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]])
        array.removeSubrange(0...7)
    
        // z - 8 bytes
        let z = try Double([array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]])
        array.removeSubrange(0...7)
        
        position = Coordinates<Double>(x: x, y: y, z: z)
    }
    
    
    /// Used to init size, latency, and position. Returns latency. Owner must check for porper array size
    mutating func initForPositionWithLatency(_ array: inout [UInt8]) throws -> UInt16 {
        // size - 2 bytes
        size = try integerWithBytes([array[0], array[1]])
        array.removeSubrange(0...1)
        
        // latency - 2 bytes
        let latency: UInt16 = try integerWithBytes([array[0], array[1]])
        array.removeSubrange(0...1)
        
        // x - 8 bytes
        let x = try Double([array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]])
        array.removeSubrange(0...7)
        
        // y - 8 bytes
        let y = try Double([array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]])
        array.removeSubrange(0...7)
    
        // z - 8 bytes
        let z = try Double([array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]])
        array.removeSubrange(0...7)
        
        position = Coordinates<Double>(x: x, y: y, z: z)
        return latency
    }
}





public protocol PositionAccelerationVelocity: Position {
    var acceleration: Coordinates<Float>! {get set}
    var velocity: Coordinates<Float>! {get set}
}


extension PositionAccelerationVelocity {
    
    /// Used to init size, position, acceleration, and velocity. Owner must check for proper array size
    mutating func initForPosAccVelProtocol(_ array: inout [UInt8]) throws {
        // position
        try initForPosition(&array)
        
        // AccX - 4 bytes
        var x2 = try Float([array[0], array[1], array[2], array[3]])
        array.removeSubrange(0...3)
        
        // AccY - 4 bytes
        var y2 = try Float([array[0], array[1], array[2], array[3]])
        array.removeSubrange(0...3)
    
        // AccZ - 4 bytes
        var z2 = try Float([array[0], array[1], array[2], array[3]])
        array.removeSubrange(0...3)
        
        acceleration = Coordinates<Float>(x: x2, y: y2, z: z2)
        
        // VelX - 4 bytes
        x2 = try Float([array[0], array[1], array[2], array[3]])
        array.removeSubrange(0...3)
        
        // VelY - 4 bytes
        y2 = try Float([array[0], array[1], array[2], array[3]])
        array.removeSubrange(0...3)
    
        // VelZ - 4 bytes
        z2 = try Float([array[0], array[1], array[2], array[3]])
        array.removeSubrange(0...3)
        
        velocity = Coordinates<Float>(x: x2, y: y2, z: z2)
    }
}





//MARK: - Structs
public struct Coordinates<T>  {
    public let x, y, z: T
}






