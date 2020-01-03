import Foundation

public final class Bitfield {
    public let size: Int
    private let sizeInBytes: Int
    private var bytes: [UInt8]
    
    public var data: Data {
        get {
            return Data(bytes: self.bytes, count: self.sizeInBytes)
        }
        
        set {
            let difference = newValue.count - self.sizeInBytes
            self.bytes = difference > 0 ? [UInt8](newValue).dropLast(difference) : [UInt8](newValue)
        }
    }
    
    public init(size: Int) {
        self.size = size
        self.sizeInBytes = Int((Double(size) / 8).rounded(.up))
        self.bytes = [UInt8](repeating: 0, count: self.sizeInBytes)
    }
    
    public func isSet(atIndex index: Int) -> Bool {
        if index > self.size {
            return false
        }
        
        return self.bytes[index >> 3] & UInt8(128 >> (index % 8)) != 0
    }

    public func set(atIndex index: Int) {
        if index > self.size {
            return
        }
        
        self.bytes[index >> 3] |= 128 >> (index % 8)
    }
    
    public func unset(atIndex index: Int) {
        if index > self.size {
            return
        }
        
        self.bytes[index >> 3] &= ~(128 >> (index % 8))
    }
    
}
