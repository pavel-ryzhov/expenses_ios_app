//
//  Dependencies.swift
//  expenses
//
//  Created by pavel on 16/07/2024.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    //private static let keystore = Keystore()
    public static func registerAllServices() {
        register { Keystore() }
        register { RemoteDataSource() }
        register { RemoteSymbolsDataSource() }
        register { ChooseMainCurrencyViewModel() }
    }
}
