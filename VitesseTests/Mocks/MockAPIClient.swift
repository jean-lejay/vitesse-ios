//
//  MockAPIClient.swift
//  VitesseTests
//
//  Created by Jean Lejay on 5/8/26.
//

import Foundation
@testable import Vitesse

final class MockAPIClient: APIClientProtocol {
    
    var result: Any?
    var error: Error?
    
    func performRequest<Body: Encodable, Response: Decodable>(
        urlString: String,
        method: HTTPMethod,
        token: String?,
        body: Body?,
        expectedStatusCode: Int
    ) async throws -> Response {
        
        if let error {
            throw error
        }
        
        guard let result = result as? Response else {
            fatalError("Mock result has wrong type")
        }
        
        return result
    }
}
