#if MIXBOX_ENABLE_IN_APP_SERVICES
import Foundation

// Silly utility.
// Converts anything to string and back.
// Note that serialization method is not specified. The only thing
// you should expect is that you can decode encoded object and get the same object.
// TODO: Use Decodable and Encodable separately.
public final class GenericSerialization {
    private static let encoding: String.Encoding = .utf8
    
    public static func serialize<T: Codable>(
        value: T)
        throws
        -> String
    {
        let encoder = JSONEncoder()
        
        encoder.nonConformingFloatEncodingStrategy = .convertToString(
            positiveInfinity: "+inf",
            negativeInfinity: "-inf",
            nan: "nan"
        )
        
        return try serialize(value: value, encoder: encoder)
    }
    
    public static func serialize<T: Codable>(
        value: T,
        encoder: JSONEncoder)
        throws
        -> String
    {
        let data = try encoder.encode(Container(value: value))
        
        guard let string = String(data: data, encoding: .utf8) else {
            throw ErrorString("Can not make String from Data using \(encoding) encoding")
        }
        
        return string
    }
    
    public static func deserialize<T: Codable>(
        string: String)
        throws
        -> T
    {
        let decoder = JSONDecoder()
        
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(
            positiveInfinity: "+inf",
            negativeInfinity: "-inf",
            nan: "nan"
        )
        
        return try deserialize(string: string, decoder: decoder)
    }
    
    public static func deserialize<T: Codable>(
        string: String,
        decoder: JSONDecoder)
        throws
        -> T
    {
        guard let data = string.data(using: encoding) else {
            throw ErrorString("Can not make Data from String using \(encoding) encoding")
        }
        
        return try decoder.decode(Container<T>.self, from: data).value
    }
}

private class Container<T: Codable>: Codable {
    let value: T
    
    init(value: T) {
        self.value = value
    }
}

#endif
