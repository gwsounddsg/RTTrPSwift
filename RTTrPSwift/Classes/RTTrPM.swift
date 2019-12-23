// =================================================================
// Created by:  GW Rodriguez
// Date:        12/20/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import Foundation





public struct RTTrPM {
    
    public var trackable: Trackable?
    
    
    public init(_ array: inout [UInt8]) throws {
        let module = RTTCode(rawValue: array[0]) ?? .unknown
        
        switch module {
            case .trackedPointPosition, .trackableWithTimestamp:
                trackable = try Trackable(&array)
            default:
                throw RTTError.badModuleType(module)
        }
    }
    
    
    public func print() {
        trackable?.print()
    }
}
