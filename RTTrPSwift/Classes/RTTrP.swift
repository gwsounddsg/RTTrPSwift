// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation





public struct RTTrP {
    
    public let intSig: RTTCode.intSig
    public let fltSig: RTTCode.fltSig
    public let version: UInt16
    public let packetID: UInt32
    public let packetFormat: RTTCode.packetFormat
    public let size: UInt16
    public let context: UInt32
    public let modCount: UInt8
    public var pmPackets = [RTTrPM]()
    
    
    public init(data: [UInt8]) throws {
        let pSize = PacketSize.rttrp.rawValue
        if data.count < pSize {throw RTTError.dataNotLargeEnoughToInit(data.count, pSize)}
        var array = data
        
        // Header / Integer Signature - 2 bytes
        let headerIntSig: UInt16 = try integerWithBytes([array[0], array[1]])
        if let code = RTTCode.intSig(rawValue: headerIntSig) {intSig = code}
        else {throw RTTError.badValueFor_intSig}
        array.removeSubrange(0...1)
        
        // Header / Float Signature - 2 bytes
        let headerFltSig: UInt16 = try integerWithBytes([array[0], array[1]])
        if let code = RTTCode.fltSig(rawValue: headerFltSig) {fltSig = code}
        else {throw RTTError.badValueFor_fltSig}
        array.removeSubrange(0...1)
        
        // Header Version - 2 bytes
        version = try integerWithBytes([array[0], array[1]])
        array.removeSubrange(0...1)
        
        // Packet ID - 4 bytes
        packetID = try integerWithBytes([array[0], array[1], array[2], array[3]])
        array.removeSubrange(0...3)
        
        // Packet Format - 1 byte
        if let code = RTTCode.packetFormat(rawValue: array[0]) {packetFormat = code}
        else {throw RTTError.badValueFor_packetFormat}
        array.removeFirst()
        
        // Size of packets - 2 bytes
        size = try integerWithBytes([array[0], array[1]])
        array.removeSubrange(0...1)
        
        // Context (user definable) - 4 bytes
        context = try integerWithBytes([array[0], array[1], array[2], array[3]])
        array.removeSubrange(0...3)
        
        // Number of packet modules - 1 byte
        modCount = array[0]
        array.removeFirst()
        
        // populate trackable modules
        if fltSig == .motionBigEndian || fltSig == .motionLittleEndian {
            try populatePM(&array)
        }
        
        if !array.isEmpty {
            logging("Finshed with \(array.count) bytes remaining")
        }
    }
}





extension RTTrP {
    
    mutating func populatePM(_ array: inout [UInt8]) throws {
        while array.count > 0 {
            let newPM = try RTTrPM(&array)
            pmPackets.append(newPM)
        }
    }
    
    
    public func printHeader() {
        if !LOGGING {return}
        
        logging("======== RTTrP Packet ========")
        logging("\(intSig)", shiftRight: 1)
        logging("\(fltSig)", shiftRight: 1)
        logging("Version: \(version)", shiftRight: 1)
        logging("PacketID: \(packetID)", shiftRight: 1)
        logging("\(packetFormat)", shiftRight: 1)
        logging("Size: \(size)", shiftRight: 1)
        logging("Module Packet Count: \(modCount)", shiftRight: 1)
        
        for each in pmPackets {each.print()}
        
        print("==============================\n")
    }
}
