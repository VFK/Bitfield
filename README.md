# Bitfield

A simple bitfield implementation written in Swift for use with Package Manager.
Compatible with BitTorrent specifucation:
> <...> a bitfield representing the pieces that have been successfully downloaded. The high bit in the first byte corresponds to piece index 0. Bits that are cleared indicated a missing piece, and set bits indicate a valid and available piece. Spare bits at the end are set to zero.

## Usage

```swift
import Bitfield

let bitfield = Bitfield(size: 10)

bitfield.set(atIndex: Int) // Sets a byte at specified index to 1
bitfield.unset(atIndex: Int) // Sets a byte at specified index to 0
bitfield.isSet(atIndex: Int) -> Bool
```

To access (or set directly) bitfield data use
```swift
bitfield.data {get set} // Swift Data type 
```
