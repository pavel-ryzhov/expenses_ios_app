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
    @ObservationIgnored
    @AppStorage("mainCurrency") private(set) var mainCurrency: String?
    var isMainCurrencySaved: Bool { mainCurrency != nil }
    private(set) var sortedSymbols: [Symbol] = []
    private(set) var selectedSymbols: [Symbol] = []
    private(set) var exceptedSymbols: [Symbol] = []
    var sortingText: String = "" {
        didSet {
            if sortingText != oldValue {
                sortSymbols()
            }
        }
    }
    private var symbols: [Symbol] = []
    private(set) var areSymbolsLoaded = false
    private(set) var loadingSymbolsFailed = false
    
    func fetchSymbols() {
        guard !areSymbolsLoaded else { return }
        loadingSymbolsFailed = false
        Task {
            if let symbols = await dataSource.fetchSymbols() {
                self.symbols = symbols
                areSymbolsLoaded = true
                sortSymbols()
            } else {
                loadingSymbolsFailed = true
            }
        }
    }
    
    private func sortSymbols() {
        sortedSymbols = (sortingText.isEmpty ? symbols : symbols.filter { symbol in symbol.code.lowercased().contains(sortingText.lowercased()) || symbol.descr.contains(sortingText.lowercased()) })
            .filter { symbol in !selectedSymbols.contains(symbol) && !exceptedSymbols.contains(symbol) }
    }
    
    func selectSymbol(_ symbol: Symbol) {
        selectedSymbols.append(symbol)
        sortSymbols()
    }
    
    func deselectSymbol(_ symbol: Symbol) {
        selectedSymbols.remove(at: selectedSymbols.firstIndex(of: symbol)!)
        sortSymbols()
    }
    
    func exceptSymbol(_ symbol: Symbol) {
        exceptedSymbols.append(symbol)
        sortSymbols()
    }
    
    func saveMainCurrency(_ symbol: Symbol) {
        mainCurrency = symbol.code
        exceptSymbol(symbol)
    }
}
