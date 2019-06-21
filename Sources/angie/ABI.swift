// Based on https://solidity.readthedocs.io/en/v0.5.3/abi-spec.html#json .

indirect enum ABIValueType {
    case uint(size: UInt8) // size is 0<..256, represented here as 0..<255; no size = 256
    case int(size: UInt8) // size is 0<..256, represented here as 0..<255; no size = 256
    case address
    case bool
    case fixed(bits: UInt8 /* 8...256 */, decimals: UInt8 /* 0<..80 */) // value = v / 10 ** decimals; no prefix = 128, 18
    case ufixed(bits: UInt8, decimals: UInt8) // same as above, no sign bit; no size = 128, 18
    case bytes(count: UInt8? /* 0<..32, or dynamic */)
    case function /* [ 20 byte address | 4 byte selector ] */
    case array(type: ABIValueType, size: UInt?)
    case string
    case tuple(types: [ABIValueType])
}

enum ABIFunctionType {
    case function
    case constructor
    case fallback
}

enum ABIEventType {
    case event
}

enum ABIFunctionStateMutability {
    case pure // doesn't read state
    case view // doesn't write state
    case nonpayable // doesn't accept ether
    case payable // accepts ether
}

struct ABIFunctionInput {
    let name: String
    let type: ABIValueType
    let components: [String]
}

struct ABIFunctionOutput {
    let name: String
    let type: ABIValueType
    let components: [String]
}

struct ABIEventInput {
    let name: String
    let type: ABIValueType
    let components: [String]
    let indexed: Bool
}

struct ABIFunction: ABIMethod {
    let type = ABIFunctionType.function // default: .function
    let name: String // only for .function type
    let inputs: [ABIFunctionInput] // only for .function and .constructor
    let outputs: [ABIFunctionOutput]? // only for .function type that returns
    let stateMutability: ABIFunctionStateMutability
    let payable: Bool // default: false
    let constant: Bool // default: false
}

struct ABIEvent {
    let type: ABIEventType
    let name: String // only for .function type
    let inputs: [ABIEventInput] // only for .function and .constructor
    let anonymous: Bool
}
