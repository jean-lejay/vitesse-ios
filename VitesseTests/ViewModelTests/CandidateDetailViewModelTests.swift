//
//  CandidateDetailViewModelTests.swift
//  VitesseTests
//
//  Created by Jean Lejay on 5/9/26.
//

import XCTest
@testable import Vitesse

@MainActor
final class CandidateDetailViewModelTests: XCTestCase {
    
    // updateCandidate success
    func test_updateCandidate_updatesCandidateDetail_whenRepositorySucceeds() async {
        let repository = MockCandidateRepository()
        
        let updatedCandidate = Candidate(
            id: UUID(),
            firstName: "Alice",
            lastName: "Updated",
            email: "alice.updated@example.com",
            phone: "0601020304",
            linkedinURL: "https://linkedin.com/in/alice",
            note: "Updated note",
            isFavorite: true
        )
        
        repository.candidateToReturn = updatedCandidate
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidateDetailViewModel(
            repository: repository,
            session: session
        )
        
        let formData = CandidateFormData(
            firstName: "Alice",
            lastName: "Updated",
            email: "alice.updated@example.com",
            phone: "0601020304",
            linkedinURL: "https://linkedin.com/in/alice",
            note: "Updated note"
        )
        
        await viewModel.updateCandidate(
            candidateId: updatedCandidate.id,
            formData: formData
        )
        
        XCTAssertEqual(viewModel.candidateDetail?.id, updatedCandidate.id)
        XCTAssertEqual(viewModel.candidateDetail?.lastName, "Updated")
        XCTAssertEqual(viewModel.candidateDetail?.email, "alice.updated@example.com")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // updateCandidate failure
    func test_updateCandidate_setsErrorMessage_whenRepositoryFails() async {
        let repository = MockCandidateRepository()
        repository.error = APIError.invalidStatusCode(
            404,
            message: "Candidate not found"
        )
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidateDetailViewModel(
            repository: repository,
            session: session
        )
        
        let formData = CandidateFormData(
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: "",
            linkedinURL: "",
            note: ""
        )
        
        await viewModel.updateCandidate(
            candidateId: UUID(),
            formData: formData
        )
        
        XCTAssertNil(viewModel.candidateDetail)
        XCTAssertEqual(viewModel.errorMessage, "Candidate not found")
    }
    
    // setCandidateFavorite success
    func test_setCandidateFavorite_updatesCandidateDetail_whenRepositorySucceeds() async {
        let repository = MockCandidateRepository()
        
        let candidateId = UUID()
        let updatedCandidate = Candidate(
            id: candidateId,
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: nil,
            linkedinURL: nil,
            note: nil,
            isFavorite: true
        )
        
        repository.candidateToReturn = updatedCandidate
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidateDetailViewModel(
            repository: repository,
            session: session
        )
        
        await viewModel.setCandidateFavorite(candidateId: candidateId)
        
        XCTAssertEqual(viewModel.candidateDetail?.id, candidateId)
        XCTAssertTrue(viewModel.candidateDetail?.isFavorite == true)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // setCandidateFavorite failure
    func test_setCandidateFavorite_setsErrorMessage_whenRepositoryFails() async {
        let repository = MockCandidateRepository()
        repository.error = APIError.invalidStatusCode(
            404,
            message: "Candidate not found"
        )
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidateDetailViewModel(
            repository: repository,
            session: session
        )
        
        await viewModel.setCandidateFavorite(candidateId: UUID())
        
        XCTAssertNil(viewModel.candidateDetail)
        XCTAssertEqual(viewModel.errorMessage, "Candidate not found")
    }
    
    // updateCandidate avec email invalide
    func test_updateCandidate_setsErrorMessage_whenEmailIsInvalid() async {
        let repository = MockCandidateRepository()
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidateDetailViewModel(
            repository: repository,
            session: session
        )
        
        let formData = CandidateFormData(
            firstName: "Alice",
            lastName: "Martin",
            email: "invalid-email",
            phone: "",
            linkedinURL: "",
            note: ""
        )
        
        await viewModel.updateCandidate(
            candidateId: UUID(),
            formData: formData
        )
        
        XCTAssertNil(viewModel.candidateDetail)
        XCTAssertEqual(viewModel.errorMessage, "Please enter a valid email address")
    }
    
    // updateCandidate avec LinkedIn invalide
    func test_updateCandidate_setsErrorMessage_whenLinkedInURLIsInvalid() async {
        let repository = MockCandidateRepository()
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidateDetailViewModel(
            repository: repository,
            session: session
        )
        
        let formData = CandidateFormData(
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: "",
            linkedinURL: "not-a-url",
            note: ""
        )
        
        await viewModel.updateCandidate(
            candidateId: UUID(),
            formData: formData
        )
        
        XCTAssertNil(viewModel.candidateDetail)
        XCTAssertEqual(viewModel.errorMessage, "Please enter a valid LinkedIn URL")
    }
}

