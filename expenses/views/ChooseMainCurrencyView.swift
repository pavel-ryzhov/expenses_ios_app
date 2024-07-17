//
//  ChooseMainCurrencyView.swift
//  expenses
//
//  Created by pavel on 14/07/2024.
//

import SwiftUI
import Resolver

struct ChooseMainCurrencyView: View {
    
    @Injected private var viewModel: ChooseMainCurrencyViewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            TextField("", text: $viewModel.sortingText, prompt: Text("Search").foregroundColor(.accentColor))
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 4).stroke()
                }
                .foregroundColor(.accentColor)
            List {
                ForEach(viewModel.sortedSymbols) { symbol in
                    VStack {
                        Text("\(symbol.code.uppercased()): \(symbol.descr)")
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.accentColor)
                        if symbol != viewModel.sortedSymbols.last {
                            Divider().background { Color.accentColor }
                        }
                    }
                        
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .padding()
        .onAppear(perform: viewModel.fetchSymbols)
        //.onChange(of: viewModel.sortingText, viewModel.notifySortingTextChanged)
    }
}


import SwiftData
#Preview {
    ChooseMainCurrencyView().modelContainer(for: Symbol.self)
}
