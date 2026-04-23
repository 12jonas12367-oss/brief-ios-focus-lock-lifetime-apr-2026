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
                    Text("\(coordinator.lifetimePriceDisplay) one-time")
                        .font(.title2.bold())
                    Text("Localized via App Store product metadata")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Button("Unlock — \(coordinator.lifetimePriceDisplay)") {
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
