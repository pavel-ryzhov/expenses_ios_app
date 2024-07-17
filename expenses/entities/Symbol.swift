//
//  Symbol.swift
//  expenses
//
//  Created by pavel on 16/07/2024.
//

import Foundation
import SwiftData

@Model
class Symbol {
    @Attribute(.unique) let code: String
    let descr: String
    init(code: String, descr: String) {
        self.code = code
        self.descr = descr
    }
//    static func == (lhs: Symbol, rhs: Symbol) -> Bool {
//        return lhs.code == rhs.code
//    }
}
