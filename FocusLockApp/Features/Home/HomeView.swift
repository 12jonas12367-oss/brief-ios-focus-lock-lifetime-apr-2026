import SwiftUI

struct HomeView: View {
    @Bindable var coordinator: SessionCoordinator

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Focus Lock")
                .font(.largeTitle.bold())

            Text(coordinator.statusMessage)
                .foregroundStyle(.secondary)

            Button("Start Focus Session") {
                coordinator.openSetup()
            }
            .buttonStyle(.borderedProminent)

            if !coordinator.isUnlocked {
                Button("Unlock Lifetime") {
                    coordinator.openPaywall()
                }
                .buttonStyle(.bordered)
            }

            Spacer()
        }
        .padding(24)
        .navigationTitle("Home")
    }
}
