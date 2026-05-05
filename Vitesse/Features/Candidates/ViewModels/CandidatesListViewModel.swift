//
//  CandidatesListViewModel.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/23/26.

import Foundation
import Combine

@MainActor
final class CandidatesListViewModel: BaseViewModel {
    
    @Published private(set) var candidates: [Candidate] = []
    
    private let repository: CandidateRepositoryProtocol
    private let session: SessionViewModel
    
    init(repository: CandidateRepositoryProtocol, session: SessionViewModel) {
        self.repository = repository
        self.session = session
    }
    
    func fetchCandidates() async {
        guard let token = session.token else {
            errorMessage = "User not authenticated"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            candidates = try await repository.getCandidates(token: token)
            
        } catch {
            handleError(error, defaultMessage: "Unable to display the list of candidates")
        }
    }
    
    func createCandidate(from formData: CandidateFormData) async {
        guard let token = session.token else {
            errorMessage = "User not authenticated"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        let request = formData.toCreateCandidateRequestDTO()
        
        do {
            let newCandidate = try await repository.createCandidate(candidate: request, token: token)
            candidates.append(newCandidate)
            
        } catch {
            handleError(error, defaultMessage: "Unable to create candidate")
        }
    }
    
    func deleteCandidate(candidateId: UUID) async {
        guard let token = session.token else {
            errorMessage = "User not authenticated"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            try await repository.deleteCandidate(candidateId: candidateId, token: token)
            candidates.removeAll { $0.id == candidateId }
            
        } catch {
            handleError(error, defaultMessage: "Unable to delete candidate")
        }
    }
}

