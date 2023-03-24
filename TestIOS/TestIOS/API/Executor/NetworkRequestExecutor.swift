//
//  UserDefaultService.swift
//  TestIOS
//
//  Created by Developer on 23.03.2023.
//

import Foundation
import Combine
import CryptoKit

class NetworkRequestExecutor {
    private var token: String = ""
    private let secret = "$SECRET$".toBase64()
    private let key: SymmetricKey
    
    init() {
        self.key = SymmetricKey(data: secret.data(using: .utf8)!)
        self.getToken()
    }
    
    private func getToken() {
        let header = Header(alg: "HS256", typ: "JWT")
        let payload = Payload(uid: "f92022e6-399f-4347-9a6a-531a8aa409a7", identity: "test")
        
        let headerJSONEncoded = try? JSONEncoder().encode(header).urlSafeBase64EncodedString()
        let payloadJSONEncoded = try? JSONEncoder().encode(payload).urlSafeBase64EncodedString()
        
        guard let headerEncoded = headerJSONEncoded, let payloadEncoded = payloadJSONEncoded else {
            fatalError("JSON encoding failed")
        }
        
        let message = "\(headerEncoded).\(payloadEncoded)"
        let signature = HMAC<SHA256>.authenticationCode(for: Data(message.utf8), using: self.key)
        let signatureBase64String = Data(signature).urlSafeBase64EncodedString()
        
        self.token = "\(message).\(signatureBase64String)"
        print(self.token)
    }
    
    func createRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
