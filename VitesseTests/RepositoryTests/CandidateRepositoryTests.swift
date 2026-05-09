//
//  CandidateRepositoryTests.swift
//  VitesseTests
//
//  Created by Jean Lejay on 5/8/26.
//

import XCTest
@testable import Vitesse

@MainActor
final class CandidateRepositoryTests: XCTestCase {

    // MARK: - getCandidates
    
    func test_getCandidates_returnsMappedCandidates() async throws {
        
        let apiClient = MockAPIClient()
        
        let candidate1 = CandidateDTO(
            id: UUID(),
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: "0601020304",
            linkedinURL: nil,
            note: nil,
            isFavorite: true
        )
        
        let candidate2 = CandidateDTO(
            id: UUID(),
            firstName: "Bob",
            lastName: "Durand",
            email: "bob@example.com",
            phone: nil,
            linkedinURL: "https://linkedin.com/in/bob",
            note: "Strong profile",
            isFavorite: false
        )
        
        apiClient.result = [candidate1, candidate2]
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        let candidates = try await repository.getCandidates(token: "fake-token")
        
        XCTAssertEqual(candidates.count, 2)
        
        XCTAssertEqual(candidates[0].firstName, "Alice")
        XCTAssertEqual(candidates[0].lastName, "Martin")
        XCTAssertEqual(candidates[0].email, "alice@example.com")
        XCTAssertEqual(candidates[0].phone, "0601020304")
        XCTAssertTrue(candidates[0].isFavorite)
        
        XCTAssertEqual(candidates[1].firstName, "Bob")
        XCTAssertFalse(candidates[1].isFavorite)
        XCTAssertEqual(candidates[1].linkedinURL, "https://linkedin.com/in/bob")
        XCTAssertEqual(candidates[1].note, "Strong profile")
    }
    
    func test_getCandidates_throwsError_whenAPIClientFails() async throws {
        
        let apiClient = MockAPIClient()
        
        apiClient.error = APIError.invalidStatusCode(401, message: "Invalid JWT token")
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        do {
            _ = try await repository.getCandidates(token: "fake-token")
            
            XCTFail("Expected getCandidates to throw an error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    // MARK: - getCandidate
    
    func test_getCandidate_returnsMappedCandidate() async throws {
        
        let apiClient = MockAPIClient()
        
        let candidateId = UUID()
        apiClient.result = CandidateDTO(
            id: candidateId,
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: "0601020304",
            linkedinURL: nil,
            note: nil,
            isFavorite: true
        )
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        let candidate = try await repository.getCandidate(id: candidateId, token: "fake-token")
    
        XCTAssertEqual(candidate.id, candidateId)
        XCTAssertEqual(candidate.firstName, "Alice")
        XCTAssertTrue(candidate.isFavorite)
        
    }
    
    func test_getCandidate_throwsError_whenAPIClientFails() async throws {
        
        let apiClient = MockAPIClient()
        
        apiClient.error = APIError.invalidStatusCode(404, message: "Candidate not found")
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        do {
            _ = try await repository.getCandidate(id: UUID(), token: "fake-token")
            
            XCTFail("Expected getCandidate to throw an error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    // MARK: - createCandidate
    
    func test_createCandidate_returnsMappedCandidate() async throws {
        
        let apiClient = MockAPIClient()
        
        let candidateId = UUID()
        
        apiClient.result = CandidateDTO(
            id: candidateId,
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: "0601020304",
            linkedinURL: nil,
            note: nil,
            isFavorite: false
        )
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        let request = CandidateRequestDTO(
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: "0601020304",
            linkedinURL: nil,
            note: nil
        )
        
        let candidate = try await repository.createCandidate(
            candidate: request,
            token: "fake-token"
        )
        
        XCTAssertEqual(candidate.id, candidateId)
        XCTAssertEqual(candidate.firstName, "Alice")
        XCTAssertEqual(candidate.lastName, "Martin")
        XCTAssertEqual(candidate.email, "alice@example.com")
        XCTAssertFalse(candidate.isFavorite)
    }
        
    func test_createCandidate_throwsError_whenAPIClientFails() async throws {
        
        let apiClient = MockAPIClient()
        apiClient.error = APIError.invalidStatusCode(
            400,
            message: "Invalid candidate data"
        )
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        let request = CandidateRequestDTO(
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: "0601020304",
            linkedinURL: nil,
            note: nil
        )
        
        do {
            _ = try await repository.createCandidate(
                candidate: request,
                token: "fake-token"
            )
            XCTFail("Expected createCandidate to throw an error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    // MARK: - updateCandidate
    
    func test_updateCandidate_returnsUpdatedCandidate() async throws {
        
        let apiClient = MockAPIClient()
        
        let candidateId = UUID()
        
        apiClient.result = CandidateDTO(
            id: candidateId,
            firstName: "Alice Updated",
            lastName: "Martin",
            email: "alice.updated@example.com",
            phone: "0601020304",
            linkedinURL: "https://linkedin.com/in/alice",
            note: "Updated note",
            isFavorite: true
        )
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        let request = CandidateRequestDTO(
            firstName: "Alice Updated",
            lastName: "Martin",
            email: "alice.updated@example.com",
            phone: "0601020304",
            linkedinURL: "https://linkedin.com/in/alice",
            note: "Updated note"
        )
        
        let candidate = try await repository.updateCandidate(
                candidateId: candidateId,
                candidateDetail: request,
                token: "fake-token"
            )
        
        XCTAssertEqual(candidate.id, candidateId)
        XCTAssertEqual(candidate.firstName, "Alice Updated")
        XCTAssertEqual(candidate.lastName, "Martin")
        XCTAssertEqual(candidate.email, "alice.updated@example.com")
        XCTAssertTrue(candidate.isFavorite)
    }
    
    func test_updateCandidate_throwsError_whenAPIClientFails() async {
        let apiClient = MockAPIClient()
        
        apiClient.error = APIError.invalidStatusCode(
            404,
            message: "Candidate not found"
        )
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        let request = CandidateRequestDTO(
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: nil,
            linkedinURL: nil,
            note: nil
        )
        
        do {
            _ = try await repository.updateCandidate(
                candidateId: UUID(),
                candidateDetail: request,
                token: "fake-token"
            )
            
            XCTFail("Expected updateCandidate to throw an error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    // MARK: - deleteCandidate
    
    func test_deleteCandidate_succeeds_whenAPIClientSucceeds() async throws {
        let apiClient = MockAPIClient()
        apiClient.result = EmptyResponse()
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        try await repository.deleteCandidate(
            candidateId: UUID(),
            token: "fake-token"
        )
    }
    
    func test_deleteCandidate_throwsError_whenAPIClientFails() async {
        let apiClient = MockAPIClient()
        
        apiClient.error = APIError.invalidStatusCode(
            404,
            message: "Candidate not found"
        )
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        do {
            try await repository.deleteCandidate(
                candidateId: UUID(),
                token: "fake-token"
            )
            
            XCTFail("Expected deleteCandidate to throw an error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    // MARK: - setCandidateFavorite
    
    func test_setCandidateFavorite_returnsUpdatedCandidate() async throws {
        let apiClient = MockAPIClient()
        
        let candidateId = UUID()
        
        apiClient.result = CandidateDTO(
            id: candidateId,
            firstName: "Alice",
            lastName: "Martin",
            email: "alice@example.com",
            phone: "0601020304",
            linkedinURL: nil,
            note: nil,
            isFavorite: true
        )
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        let candidate = try await repository.setCandidateFavorite(
            candidateId: candidateId,
            token: "fake-token"
        )
        
        XCTAssertEqual(candidate.id, candidateId)
        XCTAssertTrue(candidate.isFavorite)
    }
    
    func test_setCandidateFavorite_throwsError_whenAPIClientFails() async {
        let apiClient = MockAPIClient()
        
        apiClient.error = APIError.invalidStatusCode(
            404,
            message: "Candidate not found"
        )
        
        let repository = CandidateRepository(apiClient: apiClient)
        
        do {
            _ = try await repository.setCandidateFavorite(
                candidateId: UUID(),
                token: "fake-token"
            )
            
            XCTFail("Expected setCandidateFavorite to throw an error")
        } catch {
            XCTAssertNotNil(error)
        }
    }

}

