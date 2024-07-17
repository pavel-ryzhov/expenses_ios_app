//
//  ChooseMainCurrencyViewModel.swift
//  expenses
//
//  Created by pavel on 16/07/2024.
//

import Foundation
import Resolver
import SwiftUI

@Observable
class ChooseMainCurrencyViewModel {
    
    @ObservationIgnored
    @Injected private var dataSource: RemoteSymbolsDataSource
    private(set) var sortedSymbols: [Symbol] = []
    var sortingText: String = "" {
        didSet {
            if sortingText != oldValue {
                sortSymbols()
            }
        }
    }
    private var symbols: [Symbol] = []
    
    func fetchSymbols() {
        Task {
            if let symbols = await dataSource.fetchSymbols() {
                self.symbols = symbols
                sortSymbols()
            }
        }
    }
    
    private func sortSymbols() {
        sortedSymbols = sortingText.isEmpty ? symbols : symbols.filter { symbol in symbol.code.lowercased().contains(sortingText.lowercased()) || symbol.descr.contains(sortingText.lowercased()) }
    }
}
