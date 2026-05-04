//
//  APIClient.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/25/26.
//

import Foundation

final class APIClient {
    
    func performRequest<Body: Encodable, Response: Decodable>(urlString: String, method: HTTPMethod, token: String? = nil, body: Body? = nil, expectedStatusCode: Int) async throws -> Response {
        
        // création de l'URL
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        // création de la requête
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        if let token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // requête
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // la réponse existe et est bien au format HTTP
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        let errorResponse = try? JSONDecoder().decode(ErrorResponseDTO.self, from: data)

        // Vérification du statut attendu
        guard httpResponse.statusCode == expectedStatusCode else {
            throw APIError.invalidStatusCode(httpResponse.statusCode, message: errorResponse?.reason)
        }
        
        if Response.self == EmptyResponse.self {
            return EmptyResponse() as! Response
        }
        
        return try JSONDecoder().decode(Response.self, from: data)
        
    }

}
