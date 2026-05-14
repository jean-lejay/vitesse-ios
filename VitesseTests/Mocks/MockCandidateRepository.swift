//
//  MockCandidateRepository.swift
//  VitesseTests
//
//  Created by Jean Lejay on 5/9/26.
//

import Foundation
@testable import Vitesse

final class MockCandidateRepository: CandidateRepositoryProtocol {
    
    var candidates: [Candidate] = []
    var candidateToReturn: Candidate?
    var candidateIdsThatShouldFail: Set<UUID> = []
    var error: Error?
    
    func getCandidates(token: String) async throws -> [Candidate] {
        if let error { throw error }
        return candidates
    }
    
    func getCandidate(id: UUID, token: String) async throws -> Candidate {
        if let error { throw error }
        guard let candidateToReturn else {
            fatalError("candidateToReturn not configured")
        }
        return candidateToReturn
    }
    
    func createCandidate(candidate: CandidateRequestDTO, token: String) async throws -> Candidate {
        if let error { throw error }
        guard let candidateToReturn else {
            fatalError("candidateToReturn not configured")
        }
        return candidateToReturn
    }
    
    func updateCandidate(candidateId: UUID, candidateDetail: CandidateRequestDTO, token: String) async throws -> Candidate {
        if let error { throw error }
        guard let candidateToReturn else {
            fatalError("candidateToReturn not configured")
        }
        return candidateToReturn
    }
    
    func deleteCandidate(candidateId: UUID, token: String) async throws {
        if candidateIdsThatShouldFail.contains(candidateId) {
                throw APIError.invalidStatusCode(500, message: "Unable to delete candidate")
            }
    }
    
    func setCandidateFavorite(candidateId: UUID, token: String) async throws -> Candidate {
        if let error { throw error }
        guard let candidateToReturn else {
            fatalError("candidateToReturn not configured")
        }
        return candidateToReturn
    }
}
