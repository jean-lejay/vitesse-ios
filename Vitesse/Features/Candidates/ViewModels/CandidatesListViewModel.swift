//
//  TestBackendViewModel.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/23/26.

import Foundation
import Combine

@MainActor
final class TestBackendViewModel: ObservableObject {
    
    @Published var token: String = ""
    
    private let repository = AuthRepository()
    private let candidateRepository = CandidateRepository()
    
    func createAccount(candidateDetail: RegisterUserRequestDTO) async {
        do {
            try await repository.createAccount(candidateDetail: candidateDetail)
            
        } catch {
            print("Error in account creation: \(error.localizedDescription)")
        }
    }
    
    func fetchCandidates(token: String) async {
        do {
            let candidates = try await candidateRepository.fetchCandidates(token: token)
            print(candidates)
            
        } catch {
            print("Error to get the list of candidates: \(error.localizedDescription)")
        }
    }
    
    func fetchCandidateDetail(candidateId: UUID, token: String) async {
        
        do {
            let candidateDetail = try await candidateRepository.fetchCandidateDetail(candidateId: candidateId, token: token)
            print(candidateDetail)
            
        } catch {
            print("Error to get the candidate detail: \(error.localizedDescription)")
        }
        
    }
    
    func addCandidate(candidate: CandidateRequestDTO, token: String) async {
        
        do {
            let candidateDetail = try await candidateRepository.addCandidate(candidate: candidate, token: token)
            print(candidateDetail)
            
        } catch {
            print("Error to add candidate: \(error.localizedDescription)")
        }
    }
    
    func updateCandidate(candidateId: UUID, candidateDetail: CandidateRequestDTO, token: String) async {
        
        do {
            let candidateDetailUpdated = try await candidateRepository.updateCandidate(candidateId: candidateId, candidateDetail: candidateDetail, token: token)
            print(candidateDetailUpdated)
            
        } catch {
            print("Error to update candidate: \(error.localizedDescription)")
        }
        
    }
    
    func deleteCandidate(candidateId: UUID, token: String) async {
        
        do {
            try await candidateRepository.deleteCandidate(candidateId: candidateId, token: token)
            
        } catch {
            print("Error to delete candidate: \(error.localizedDescription)")
        }
        
    }

    func setCandidateFavorite(candidateId: UUID, token: String) async {
        
        do {
            let candidateDetail = try await candidateRepository.setCandidateFavorite(candidateId: candidateId, token: token)
            print(candidateDetail)
        } catch {
            print("Error to set candidate to favorite: \(error.localizedDescription)")
            
        }
    }
    
}

