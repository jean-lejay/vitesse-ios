//
//  CandidateDetailViewModel.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/3/26.
//

import Foundation
import Combine

@MainActor
final class CandidateDetailViewModel: BaseViewModel {
    
    private let repository: CandidateRepositoryProtocol
    private let session: SessionViewModel
    
    @Published private(set) var candidateDetail: Candidate?
    
    init(repository: CandidateRepositoryProtocol, session: SessionViewModel) {
        self.repository = repository
        self.session = session
    }
    
    func fetchCandidate(id: UUID) async {
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
            candidateDetail = try await repository.getCandidate(id: id, token: token)
            
        } catch {
            handleError(error, defaultMessage: "Unable to display the candidate's details")
        }
    }
    
    func updateCandidate(candidateId: UUID, formData: CandidateFormData) async {
        guard let token = session.token else {
            errorMessage = "User not authenticated"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        let request = formData.toUpdateCandidateRequestDTO()
        
        do {
            let updatedCandidate = try await repository.updateCandidate(candidateId: candidateId, candidateDetail: request, token: token)
            candidateDetail = updatedCandidate
            
        } catch {
            handleError(error, defaultMessage: "Unable to update candidate")
        }
    }
    
    func setCandidateFavorite(candidateId: UUID) async {
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
            let updatedCandidate = try await repository.setCandidateFavorite(candidateId: candidateId, token: token)
            candidateDetail = updatedCandidate
            
        } catch {
            handleError(error, defaultMessage: "Unable to set candidate as favorite")
        }
    }
}


