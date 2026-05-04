//
//  CandidateRepository.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/23/26.
//

import Foundation

final class CandidateRepository {
    
    private let apiClient = APIClient()
    
    private let baseURL = "http://127.0.0.1:8080"
    
    func getCandidates(token: String) async throws -> [Candidate] {
        
        let candidatesDTO: [CandidateDTO] = try await apiClient.performRequest(urlString: "\(baseURL)/candidate", method: .get, token: token, body: nil as String?, expectedStatusCode: 200)
        
        return candidatesDTO.map {$0.toModel()}
    }

    func getCandidate(id: UUID, token: String) async throws -> Candidate {
        
        let candidateDetail: CandidateDTO = try await apiClient.performRequest(urlString: "\(baseURL)/candidate/\(id)", method: .get, token: token, body: nil as String?, expectedStatusCode: 200)
        
        return candidateDetail.toModel()
        
    }

    func createCandidate(candidate: CandidateRequestDTO, token: String) async throws -> Candidate {
        
        let candidateDTO: CandidateDTO = try await apiClient.performRequest(urlString: "\(baseURL)/candidate", method: .post, token: token, body: candidate, expectedStatusCode: 200)
        
        return candidateDTO.toModel()
        
    }

    func updateCandidate(candidateId: UUID, candidateDetail: CandidateRequestDTO, token: String) async throws -> Candidate {
        
        let candidateDTO: CandidateDTO = try await apiClient.performRequest(urlString: "\(baseURL)/candidate/\(candidateId)", method: .put, token: token, body: candidateDetail, expectedStatusCode: 200)
        
        return candidateDTO.toModel()
        
    }

    func deleteCandidate(candidateId: UUID, token: String) async throws {
        
        let _: EmptyResponse = try await apiClient.performRequest(urlString: "\(baseURL)/candidate/\(candidateId)", method: .delete, token: token, body: nil as String?, expectedStatusCode: 200)
        
    }

    func setCandidateFavorite(candidateId: UUID, token: String) async throws -> Candidate {
        
        let candidateDTO: CandidateDTO = try await apiClient.performRequest(urlString: "\(baseURL)/candidate/\(candidateId)/favorite", method: .post, token: token, body: nil as String?, expectedStatusCode: 200)
        
        return candidateDTO.toModel()
        
    }
    
}





