//
//  RemoteDataSource.swift
//  expenses
//
//  Created by pavel on 16/07/2024.
//

import Foundation

class RemoteDataSource {
    func fetch(_ url: String) async -> Data? {
        guard let url = URL(string: url) else { return nil }
        return await fetch(url)
    }
    func fetch(_ url: URL) async -> Data? {
        return try? await URLSession.shared.data(from: url).0
    }
}
