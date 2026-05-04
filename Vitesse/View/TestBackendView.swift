//
//  TestBackEnd.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/22/26.
//

import SwiftUI

struct TestBackendView: View {
    
    var body: some View {
        Text("Hello")
            .task {
                await testAuthenticatedCandidateRequest()
            }
    }
    
    func testAuthenticatedCandidateRequest() async {
        do {
            let token = try await authenticate()
            print("TOKEN:", token)
            
            try await addCandidate(candidate: CreateCandidateRequestDTO(firstName: "John", lastName: "Lenoir", email: "john.doe@gmail.com", phone: nil, linkedinURL: nil, note: nil), token: token)
            
            let candidates = try await fetchCandidates(token: token)
            print(candidates)
            
            guard let firstCandidate = candidates.first else {
                print("Aucun candidat")
                return
            }
            
            let candidate = try await fetchCandidateDetail(candidateId: firstCandidate.id, token: token)
            print("Bonjour Jean")
            print(candidate)
            print("Hélianthal")
            
        } catch {
            print("Erreur:", error)
        }
    }
    
    func authenticate() async throws -> String {
        guard let url = URL(string: "http://127.0.0.1:8080/user/auth") else {
            throw URLError(.badURL)
        }
        
        let requestBody: [String: String] = [
            "email" : "admin@vitesse.com",
            "password" : "test123"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
        return authResponse.token
        
    }
    
    func addCandidate(candidate: CreateCandidateRequestDTO, token: String) async throws {
        guard let url = URL(string: "http://127.0.0.1:8080/candidate") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(candidate)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
    }
    
    func fetchCandidateDetail(candidateId: UUID, token: String) async throws -> CandidateDTO {
        
        guard let url = URL(string: "http://127.0.0.1:8080/candidate/\(candidateId)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let candidateDetail = try JSONDecoder().decode(CandidateDTO.self, from: data)
        return candidateDetail
        
    }
    
    func fetchCandidates(token: String) async throws -> [CandidateDTO] {
        
        guard let url = URL(string: "http://127.0.0.1:8080/candidate") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        print(String(data: data, encoding: .utf8) ?? "nil")
        
        let candidates = try JSONDecoder().decode([CandidateDTO].self, from: data)
        return candidates
    }
    
    func updateCandidate(candidateId: UUID, candidateDetail: CreateCandidateRequestDTO, token: String) async throws {
        
        guard let url = URL(string: "http://127.0.0.1:8080/candidate/\(candidateId)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(candidateDetail)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
    }
    
    func deleteCandidate(candidateId: UUID, token: String) async throws {
        
        guard let url = URL(string: "http://127.0.0.1:8080/candidate/\(candidateId)") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
    }
    
    func setCandidateFavorite(candidateId: UUID, token: String) async throws {
        
        guard let url = URL(string: "http://127.0.0.1:8080/candidate/\(candidateId)/favorite") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
    }
    
    func createAccount(candidateDetail: RegisterUserRequestDTO) async throws {
        
        guard let url = URL(string: "http://127.0.0.1:8080/user/register") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(candidateDetail)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
    }
}
    
struct AuthResponse: Decodable {
    let isAdmin: Bool
    let token: String
}

struct RegisterUserRequestDTO: Encodable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
}

#Preview {
    TestBackEnd()
}
