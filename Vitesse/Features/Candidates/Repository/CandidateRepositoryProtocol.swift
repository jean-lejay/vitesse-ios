//
//  CandidateRepositoryProtocol.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/4/26.
//

import Foundation

protocol CandidateRepositoryProtocol {
    func getCandidates(token: String) async throws -> [Candidate]
    func getCandidate(id: UUID, token: String) async throws -> Candidate
    func createCandidate(candidate: CandidateRequestDTO, token: String) async throws -> Candidate
    func updateCandidate(candidateId: UUID, candidateDetail: CandidateRequestDTO, token: String) async throws -> Candidate
    func deleteCandidate(candidateId: UUID, token: String) async throws
    func setCandidateFavorite(candidateId: UUID, token: String) async throws -> Candidate
}
