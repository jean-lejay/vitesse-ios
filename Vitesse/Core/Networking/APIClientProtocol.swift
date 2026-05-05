//
//  APIClientProtocol.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/5/26.
//

import Foundation

protocol APIClientProtocol {
    func performRequest<Body: Encodable, Response: Decodable>(urlString: String, method: HTTPMethod, token: String?, body: Body?, expectedStatusCode: Int) async throws -> Response
}
