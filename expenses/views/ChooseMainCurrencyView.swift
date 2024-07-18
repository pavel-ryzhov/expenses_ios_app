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
        NavigationView {
            VStack {
                TextField("", text: $viewModel.sortingText, prompt: Text("Search").foregroundColor(.accentColor))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 8).stroke()
                    }
                    .foregroundColor(.accentColor)
                if viewModel.areSymbolsLoaded {
                    List {
                        ForEach(viewModel.sortedSymbols) { symbol in
                            VStack {
                                Text("\(symbol.code.uppercased()): \(symbol.descr)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.accentColor)
                                    .background {
                                        NavigationLink("", destination: {
                                            ChooseSecondaryCurrenciesView().onAppear {
                                                viewModel.saveMainCurrency(symbol)
                                            }
                                        })
                                        .opacity(0)
                                    }
                                if symbol != viewModel.sortedSymbols.last {
                                    Divider().background { Color.accentColor }
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                } else if viewModel.loadingSymbolsFailed {
                    Button("Try to reload", action: viewModel.fetchSymbols)
                        .padding()
                        .background(Color.accentColor.cornerRadius(8))
                        .foregroundColor(.milkyWhite)
                        .padding()
                } else {
                    ProgressView()
                        .tint(.accentColor)
                        .controlSize(.large)
                        .padding()
                }
                Spacer()
            }
            .padding()
            .background(.milkyWhite)
            .onAppear(perform: viewModel.fetchSymbols)//.navigationBarHidden(true)
            .navigationBarItems(leading: Text("Main currency")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
            )
        }
    }
}

import SwiftData
#Preview {
    ChooseMainCurrencyView().modelContainer(for: Symbol.self)
}
