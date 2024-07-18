//
//  ChooseSecondaryCurrenciesView.swift
//  expenses
//
//  Created by pavel on 18/07/2024.
//

import SwiftUI
import Resolver

struct ChooseSecondaryCurrenciesView: View {
    
    @Injected private var viewModel: ChooseMainCurrencyViewModel
    @State var hui = false
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
                        Group {
                            Section {
                                ForEach(viewModel.selectedSymbols) { symbol in
                                    VStack {
                                        Checkbox(text: "\(symbol.code.uppercased()): \(symbol.descr)", isOn: Binding(get: { true }, set: { _ in
                                            viewModel.deselectSymbol(symbol)
                                        }))
                                        if symbol != viewModel.selectedSymbols.last {
                                            Divider().background { Color.accentColor }
                                        }
                                    }
                                }
                            }
                            Section {
                                ForEach(viewModel.sortedSymbols) { symbol in
                                    VStack {
                                        Checkbox(text: "\(symbol.code.uppercased()): \(symbol.descr)", isOn: Binding(get: { false }, set: { _ in
                                            viewModel.selectSymbol(symbol)
                                        }))
                                        if symbol != viewModel.sortedSymbols.last {
                                            Divider().background { Color.accentColor }
                                        }
                                    }
                                }
                                
                            }
                        }
                        .listSectionSpacing(.compact)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .frame(maxHeight: .infinity)
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
                if viewModel.areSymbolsLoaded {
                    NavigationLink(destination: {
                        Text("MainView")
                    }, label: {
                        Text("Submit")
                            .padding()
                            .background(Color.accentColor.cornerRadius(8))
                            .foregroundColor(.milkyWhite)
                    })
                }
            }
            .padding()
            .onAppear(perform: viewModel.fetchSymbols)
            .navigationBarItems(leading: Text("Secondary currencies")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
            )
            .background(.milkyWhite).ignoresSafeArea(edges: .bottom)
        }
    }
}

struct Checkbox: View {
    var text: String
    @Binding var isOn: Bool
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(.accent, lineWidth: 2)
                .frame(width: 24, height: 24)
                .cornerRadius(4.0)
                .overlay {
                    Image(systemName: isOn ? "checkmark" : "")
                        .foregroundColor(.accentColor)
                }
            Text(text)
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .onTapGesture {
            isOn.toggle()
        }
    }
}

import SwiftData
#Preview {
    ChooseSecondaryCurrenciesView().modelContainer(for: Symbol.self)
}
