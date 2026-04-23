import SwiftUI

struct PaywallView: View {
    @Bindable var coordinator: SessionCoordinator

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Unlock Focus Lock Lifetime")
                    .font(.largeTitle.bold())

                Text("One-time purchase. No subscription. Keeps free tier usable.")
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Price")
                        .font(.headline)
                    Text("$7.99 one-time")
                        .font(.title2.bold())
                    Text("TODO: Replace with StoreKit localized product price.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Button("Unlock — $7.99") {
                    coordinator.purchaseLifetimeUnlock()
                }
                .buttonStyle(.borderedProminent)

                Button("Restore Purchases") {
                    coordinator.restorePurchases()
                }
                .buttonStyle(.bordered)

                Spacer()
            }
            .padding(24)
            .navigationTitle("Lifetime Unlock")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        coordinator.isShowingPaywall = false
                    }
                }
            }
        }
    }
}
