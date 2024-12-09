import SwiftUI

struct OrderView: View {
    let product: Product?
    let size: String
    let extras: [String]
    let total: Double

    var body: some View {
        VStack(spacing: 20) {
            Text("Your order")
                .font(.title)
                .bold()

            if let product = product {
                // Check if there are extras and format the text accordingly
                let extrasText = extras.isEmpty ? "" : " with \(extras.joined(separator: ", "))"
                Text("\(size) \(product.name)\(extrasText)")
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                Text("No product selected.")
            }

            

            // Ajouter l'image ici
            Image("coffee_cup") // Remplacez "coffee_cup" par le nom de votre image
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()

            Button(action: {
                // Handle order confirmation
            }) {
                Text("Order now for €\(total, specifier: "%.2f")")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Your Order")
    }
}
