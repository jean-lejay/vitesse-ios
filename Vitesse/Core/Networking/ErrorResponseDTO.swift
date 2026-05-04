//
//  ErrorResponse.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/29/26.
//

import Foundation

struct ErrorResponseDTO: Decodable {
    let error: Bool
    let reason: String
}
