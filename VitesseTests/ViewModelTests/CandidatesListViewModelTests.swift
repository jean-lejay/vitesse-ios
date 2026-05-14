//
//  CandidatesListViewModelTests.swift
//  VitesseTests
//
//  Created by Jean Lejay on 5/9/26.
//

import XCTest
@testable import Vitesse

@MainActor
final class CandidatesListViewModelTests: XCTestCase {
    
    // fetchCandidates success
    func test_fetchCandidates_updatesCandidates_whenRepositorySucceeds() async {
        let repository = MockCandidateRepository()
        repository.candidates = [
            Candidate(
                id: UUID(),
                firstName: "Alice",
                lastName: "Martin",
                email: "alice@example.com",
                phone: nil,
                linkedinURL: nil,
                note: nil,
                isFavorite: false
            )
        ]
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidatesListViewModel(
            repository: repository,
            session: session
        )
        
        await viewModel.fetchCandidates()
        
        XCTAssertEqual(viewModel.candidates.count, 1)
        XCTAssertEqual(viewModel.candidates.first?.firstName, "Alice")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // fetchCandidates failure
    func test_fetchCandidates_setsErrorMessage_whenRepositoryFails() async {
        let repository = MockCandidateRepository()
        repository.error = APIError.invalidStatusCode(
            401,
            message: "Invalid JWT token"
        )
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidatesListViewModel(
            repository: repository,
            session: session
        )
        
        await viewModel.fetchCandidates()
        
        XCTAssertTrue(viewModel.candidates.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Invalid JWT token")
    }
    
    // createCandidate success
    func test_createCandidate_appendsCandidate_whenRepositorySucceeds() async {
        let repository = MockCandidateRepository()
        
        let createdCandidate = Candidate(
            id: UUID(),
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: nil,
            linkedinURL: nil,
            note: nil,
            isFavorite: false
        )
        
        repository.candidateToReturn = createdCandidate
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidatesListViewModel(
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
        
        await viewModel.createCandidate(from: formData)
        
        XCTAssertEqual(viewModel.candidates.count, 1)
        XCTAssertEqual(viewModel.candidates.first?.firstName, "Alice")
    }
    
    // createCandidate repository failure
    func test_createCandidate_setsErrorMessage_whenRepositoryFails() async {
        let repository = MockCandidateRepository()
        repository.error = APIError.invalidStatusCode(500, message: "Server error")
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidatesListViewModel(
            repository: repository,
            session: session
        )
        
        let formData = CandidateFormData(
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: "",
            linkedinURL: "",
            note: "",
        )
        
        await viewModel.createCandidate(from: formData)
        
        XCTAssertTrue(viewModel.candidates.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Server error")
    }
    
    // deleteCandidates success
    
    func test_deleteCandidates_removesSelectedCandidates_whenRepositorySucceeds() async {
        let repository = MockCandidateRepository()
        
        let candidate1 = Candidate(id: UUID(), firstName: "Alice", lastName: "Martin", email: "alice@example.com", phone: nil, linkedinURL: nil, note: nil, isFavorite: false)
        let candidate2 = Candidate(id: UUID(), firstName: "Bob", lastName: "Durand", email: "bob@example.com", phone: nil, linkedinURL: nil, note: nil, isFavorite: false)
        let candidate3 = Candidate(id: UUID(), firstName: "Claire", lastName: "Petit", email: "claire@example.com", phone: nil, linkedinURL: nil, note: nil, isFavorite: false)
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidatesListViewModel(
            repository: repository,
            session: session
        )
        
        viewModel.candidates = [candidate1, candidate2, candidate3]
        
        await viewModel.deleteCandidates(candidateIds: [
            candidate1.id,
            candidate3.id
        ])
        
        XCTAssertEqual(viewModel.candidates.count, 1)
        XCTAssertEqual(viewModel.candidates.first?.id, candidate2.id)
    }
    

    // deleteCandidates partial failure
    
    func test_deleteCandidates_keepsFailedCandidate_whenDeletionFails() async {
        let repository = MockCandidateRepository()
        
        let candidate1 = Candidate(id: UUID(), firstName: "Alice", lastName: "Martin", email: "alice@example.com", phone: nil, linkedinURL: nil, note: nil, isFavorite: false)
        let candidate2 = Candidate(id: UUID(), firstName: "Bob", lastName: "Durand", email: "bob@example.com", phone: nil, linkedinURL: nil, note: nil, isFavorite: false)
        let candidate3 = Candidate(id: UUID(), firstName: "Claire", lastName: "Petit", email: "claire@example.com", phone: nil, linkedinURL: nil, note: nil, isFavorite: false)
        
        repository.candidateIdsThatShouldFail = [candidate2.id]
        
        let session = SessionViewModel()
        session.login(token: "fake-token", isAdmin: true)
        
        let viewModel = CandidatesListViewModel(
            repository: repository,
            session: session
        )
        
        viewModel.candidates = [candidate1, candidate2, candidate3]
        
        await viewModel.deleteCandidates(candidateIds: [
            candidate1.id,
            candidate2.id,
            candidate3.id
        ])
        
        XCTAssertTrue(viewModel.candidates.contains { $0.id == candidate2.id })
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
