import SwiftUI
import MessageUI


struct MailView: UIViewControllerRepresentable {
    let subject: String
    let body: String
    let recipient: String

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isPresented: Bool

        init(isPresented: Binding<Bool>) {
            _isPresented = isPresented
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
            isPresented = false
        }
    }

    @Binding var isPresented: Bool

    func makeCoordinator() -> Coordinator {
        return Coordinator(isPresented: $isPresented)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setSubject(subject)
        vc.setMessageBody(body, isHTML: false)
        vc.setToRecipients([recipient])
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}

struct OrderView: View {
    let product: Product?
    let size: String
    let extras: [String]
    let total: Double

    @State private var isShowingMailView = false
    @State private var isMailAvailable = MFMailComposeViewController.canSendMail()

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Your order")
                .font(.title)
                .bold()

            // Order Details
            if let product = product {
                let extrasText = extras.isEmpty ? "" : " with \(extras.joined(separator: ", "))"
                Text("\(size) \(product.name)\(extrasText)")
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                Text("No product selected.")
            }

            // Total Price
            Text("Total: €\(total, specifier: "%.2f")")
                .font(.headline)
                .padding()

            // Image of the order
            Image("coffee_cup") // Replace with your image name
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()

            // Email Button
            Button(action: {
                if isMailAvailable {
                    isShowingMailView = true
                } else {
                    print("Email not available on this device.")
                }
            }) {
                Text("Order now for €\(total, specifier: "%.2f")")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .sheet(isPresented: $isShowingMailView) {
                MailView(
                    subject: "\(size) \(product?.name ?? "Order")",
                    body: emailBody(),
                    recipient: "coffee-m2sime@univ-rouen.fr",
                    isPresented: $isShowingMailView
                )
            }
        }
        .padding()
        .navigationTitle("Your Order")
    }

    private func emailBody() -> String {
        var body = "Order Details:\n\n"
        body += "Drink: \(product?.name ?? "None")\n"
        body += "Size: \(size)\n"

        if !extras.isEmpty {
            body += "Extras:\n"
            for extra in extras {
                body += "- \(extra)\n"
            }
        }

        body += String(format: "\nTotal Price: €%.2f\n", total)

        return body
    }
}
