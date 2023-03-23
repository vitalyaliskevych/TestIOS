import Combine
import CryptoKit
import Foundation

func getToken() {
    let header = Header(alg: "HS256", typ: "JWT")
    let payload = Payload(uid: "f92022e6-399f-4347-9a6a-531a8aa409a7", identity: "test")
    
    let headerJSONEncoded = try? JSONEncoder().encode(header).urlSafeBase64EncodedString()
    let payloadJSONEncoded = try? JSONEncoder().encode(payload).urlSafeBase64EncodedString()
    let secret = "$SECRET$".toBase64()
    
    if let headerJSONEncoded = headerJSONEncoded, let payloadJSONEncoded = payloadJSONEncoded {
        let key = SymmetricKey(data: secret.data(using: .utf8)!)
        
        let signature = HMAC<SHA256>.authenticationCode(for: Data("\(headerJSONEncoded).\(payloadJSONEncoded)".utf8), using: key)
        let signatureBase64String = Data(signature).urlSafeBase64EncodedString()
        
        token = [headerJSONEncoded, payloadJSONEncoded, signatureBase64String].joined(separator: ".")
        print(token)
    } else {
        fatalError("JSON  error")
    }
}


