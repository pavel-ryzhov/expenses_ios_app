//
//  SymbolRemote.swift
//  expenses
//
//  Created by pavel on 17/07/2024.
//

import Foundation

struct SymbolsRemote: Decodable {
    
    let success: Bool
    let terms, privacy: String
    let currencies: [String: String]
    
    func toSymbols() -> [Symbol] {
        return currencies.map { Symbol(code: $0, descr: $1) }
    }
}
