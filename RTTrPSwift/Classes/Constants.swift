// =================================================================
// Created by:  GW Rodriguez
// Date:        12/19/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation




let LOGGING = true




public enum PacketSize: Int {
    case rttrp = 18
    case trackable = 6
    case centroidPosition = 28
    case trackedPointPosition = 29
    case quaternion = 36
    case euler = 30
    case centroidAccVel = 50
    case trackedPointAccVel = 51
}





public enum RTTError: Error, Equatable {
    case badByteCountForReturnType
    
    case dataNotLargeEnoughToInit(Int, Int)
    case badValueFor_intSig, badValueFor_fltSig
    case badValueFor_packetFormat
    case badModuleType(_ type: RTTCode)
    
    case cannotCreateStringForName
    case typeShouldBeTrackable
    case badUInt8Val
    
    case byteCountTooSmallToInit(_ type: RTTCode)
}





/// Values derived from the RTTrP protocol
public enum RTTCode: UInt8 {
    case trackable = 0x01
    case trackableWithTimestamp = 0x51
    case centroidPosition = 0x02
    case orientationQuaternion = 0x03
    case orientationEuler = 0x04
    case trackedPointPosition = 0x06
    case centroidAccVel = 0x20
    case trackedPointAccVel = 0x21
    case zoneCollisionDetection = 0x22
    case unknown = 0xFF
    
    public enum intSig: UInt16 {
        case bigEndian = 0x4154
        case littleEndian = 0x5441
    }
    
    public enum fltSig: UInt16 {
        case motionBigEndian = 0x4334
        case motionLittleEndian = 0x3443
        case lightingBigEndian = 0x4434
        case lightingLittleEndian = 0x3444
    }
    
    public enum packetFormat: UInt8 {
        case raw = 0x00
        case protobuf = 0x01
        case thrift = 0x02
    }
}



