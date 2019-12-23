// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation





public struct Trackable: Packet {
    // Packet
    public let type: RTTCode
    public var size: uint16
    
    // Local
    public let nameLength: uint8
    public let name: String
    public let moduleCount: uint8
    public let timestamp: uint32
    public var submodules = [RTTCode: [Packet]]()
    
    
    public init(_ array: inout [UInt8]) throws {
        if array.count < PacketSize.trackable.rawValue {throw RTTError.byteCountTooSmallToInit(.trackable)}
        
        // Type - 1 byte
        type = RTTCode(rawValue: array[0]) ?? .unknown
        array.removeFirst()
        
        // Size - 2 bytes
        size = try integerWithBytes([array[0], array[1]])
        array.removeSubrange(0...1)
        
        // Name Length - 1 byte
        nameLength = array[0]
        array.removeFirst()
        
        // Name - UTF8
        if nameLength == 1 {
            let nameData = Data(array[0...0])
            guard let str = String(bytes: nameData, encoding: .utf8) else {
                throw RTTError.cannotCreateStringForName
            }
            name = str
            array.removeFirst()
        }
        else { // name is longer than 1 character
            let nameRange = 0..<Int(nameLength - 1)
            guard let str = String(bytes: array[nameRange], encoding: .utf8) else {
                throw RTTError.cannotCreateStringForName
            }
            name = str
            array.removeSubrange(nameRange)
        }
        
        // Timestamp - 4 bytes
        if type == .trackableWithTimestamp {
            timestamp = try integerWithBytes([array[0], array[1], array[2], array[3]])
            array.removeSubrange(0...3)
        }
        else {
            timestamp = 0
        }
        
        // Number of packet modules - 1 byte
        moduleCount = array[0]
        array.removeFirst()
        
        // build sub modules
        try buildSubModules(&array)
    }
}





extension Trackable {
    
    /// Recursive method to build remaining submodules
    mutating func buildSubModules(_ array: inout [UInt8]) throws {
        if array.isEmpty {return}
        
        let module = RTTCode(rawValue: array[0]) ?? .unknown
        
        switch module {
            case .trackable, .trackableWithTimestamp:
                return
            case .centroidAccVel:
                array.removeFirst()
                submodules[.centroidAccVel] = [try CentroidAccVel(&array)]
            case .trackedPointAccVel:
                array.removeFirst()
                let newMod = try TrackedPointAccVel(&array)
                if submodules[.trackedPointAccVel] == nil {submodules[.trackedPointAccVel] = [newMod]}
                else {submodules[.trackedPointAccVel]?.append(newMod)}
            default:
                logging("Error: UInt8 value: \(array[0])", shiftRight: 2)
                throw RTTError.badUInt8Val
        }
        
        try buildSubModules(&array)
    }
    
    
    public func print() {
       logging("==================Trackable Module==================", shiftRight: 2)
        
        logging("Size: \(size)", shiftRight: 2)
        logging("Packet Name Length: \(nameLength)", shiftRight: 2)
        logging("Name: \(name)", shiftRight: 2)
        logging("Number of Modules: \(moduleCount)", shiftRight: 2)
        
        if type == .trackableWithTimestamp {logging("Timestamp: ", shiftRight: 2)}
        
        submodules.forEach { (key, value) in
            value.forEach { (item) in item.print()}
        }
        
        logging("================================", shiftRight: 2)
    }
}
