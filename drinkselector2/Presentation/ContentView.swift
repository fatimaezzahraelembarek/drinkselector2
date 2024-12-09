//
//  DrinkSelectionView.swift
//  drinkselector2
//
//  Created by Fatima Ezzahrae LEMBAREK on 09/12/2024.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DrinkSelectionViewModel(
        productUseCase: ProductUseCase(repository: RemoteProductRepository())
    )

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Choose your drink").font(.title).bold()

                // Product selection
                ForEach(viewModel.fetchProducts(), id: \.name) { product in
                    RadioButton(
                        title: product.name,
                        isSelected: viewModel.selectedProduct?.name == product.name
                    ) {
                        viewModel.selectedProduct = product
                        viewModel.updateTotal()
                    }
                }

                // Size selection
                Text("Size").font(.headline)
                Picker("Size", selection: $viewModel.selectedSize) {
                    Text("Small").tag("Small")
                    Text("Medium").tag("Medium")
                    Text("Large").tag("Large")
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: viewModel.selectedSize) { _ in viewModel.updateTotal() }

                // Extras
                Text("Extras").font(.headline)
                Toggle("Sugar (Free)", isOn: $viewModel.addSugar)
                    .disabled(!(viewModel.selectedProduct?.sugarAvailable ?? true))
                    .onChange(of: viewModel.addSugar) { _ in viewModel.updateTotal() }

                Toggle("Whipped Cream (€1.50)", isOn: $viewModel.addWhippedCream)
                    .onChange(of: viewModel.addWhippedCream) { _ in viewModel.updateTotal() }

                // Total and Purchase
                Text("Total: €\(viewModel.total, specifier: "%.2f")")
                Text("€\(viewModel.availableCredits, specifier: "%.2f") on your card")
                    .foregroundColor(.secondary)

                NavigationLink(
                    destination: OrderView(
                        product: viewModel.selectedProduct,
                        size: viewModel.selectedSize,
                        extras: viewModel.addSugar ? ["Sugar"] + (viewModel.addWhippedCream ? ["Whipped Cream"] : []) : (viewModel.addWhippedCream ? ["Whipped Cream"] : []),
                        total: viewModel.total
                    )
                ) {
                    Text("Purchase")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.total <= viewModel.availableCredits ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(viewModel.total > viewModel.availableCredits)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Insufficient Credits"),
                        message: Text("You do not have enough credits to complete the purchase."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .padding()
            .navigationTitle("Drink Selector")
        }
    }
}
