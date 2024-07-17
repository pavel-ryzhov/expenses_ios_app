//
//  RemoteSymbolsDataSource.swift
//  expenses
//
//  Created by pavel on 16/07/2024.
//

import Foundation
import Resolver

class RemoteSymbolsDataSource {
    
    @Injected private var keystore: Keystore
    @Injected private var dataSource: RemoteDataSource
    
    func fetchSymbols() async -> [Symbol]? {
        guard let url = URL(string: keystore.API_URL)?.appending(path: "list").appending(queryItems: [URLQueryItem(name: "access_key", value: keystore.API_ACCESS_KEY)]) else { return nil }
        guard let data = await dataSource.fetch(url) else { return nil }
        guard let symbols = try? JSONDecoder().decode(SymbolsRemote.self, from: data).toSymbols() else { return nil }
        return symbols
    }
}
