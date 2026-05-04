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
    
    func scenarioTestBackend() async {
        print("testScenario")
        await authenticate(email: "admin@vitesse.com", password: "test123")
        print("TOKEN:", token)
        //await fetchCandidates(token: token)
//        await createAccount(candidateDetail: RegisterUserRequestDTO(firstName: "John", lastName: "Dough", email: "johnathan.doe184@yahoo.fr", password: "El346"))
        //await authenticate(email: "johnathan.doe184@yahoo.fr", password: "El346")
        
//        Création d'un candidat
//          await addCandidate(candidate: CandidateRequestDTO(firstName: "John", lastName: "Lejaune", email: "john.doe@gmail.com", phone: nil, linkedinURL: nil, note: nil), token: token)
//        Récupération de la liste des candidats
        
//        Mise à jour du profil du candidat
        guard let id = UUID(uuidString: "A6CA4083-4B28-4DFC-8E39-3AA7338E9E10") else {
            fatalError("UUID invalide")
        }
        
//        await updateCandidate(candidateId: id, candidateDetail: CandidateRequestDTO(firstName: "John", lastName: "Lejaune", email: "john.doen@gmail.com", phone: nil, linkedinURL: nil, note: nil), token: token)
//        await fetchCandidates(token: token)
//        await fetchCandidateDetail(candidateId: id, token: token)
//        Récupération de la liste des candidats
//        Ajout du candidat en favori
//        await fetchCandidateDetail(candidateId: id, token: token)
//        await fetchCandidateDetail(candidateId: id, token: token)
//        await setCandidateFavorite(candidateId: id, token: token)
//        await fetchCandidateDetail(candidateId: id, token: token)
//        Récupération de la liste des candidats
        await deleteCandidate(candidateId: id, token: token)
        await fetchCandidateDetail(candidateId: id, token: token)
        
        
    }
    
}

//func testAuthenticatedCandidateRequest() async {
//    do {
//        let token = try await authenticate()
//        print("TOKEN:", token)
//        
//        try await addCandidate(candidate: CreateCandidateRequestDTO(firstName: "John", lastName: "Lenoir", email: "john.doe@gmail.com", phone: nil, linkedinURL: nil, note: nil), token: token)
//        
//        let candidates = try await fetchCandidates(token: token)
//        print(candidates)
//        
//        guard let firstCandidate = candidates.first else {
//            print("Aucun candidat")
//            return
//        }
//        
//        let candidate = try await fetchCandidateDetail(candidateId: firstCandidate.id, token: token)
//        print("Bonjour Jean")
//        print(candidate)
//        print("Hélianthal")
//        
//    } catch {
//        print("Erreur:", error)
//    }
//}
