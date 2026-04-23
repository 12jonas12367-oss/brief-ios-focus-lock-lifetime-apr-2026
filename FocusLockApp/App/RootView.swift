import SwiftUI

struct RootView: View {
    @Bindable var coordinator: SessionCoordinator

    var body: some View {
        NavigationStack {
            HomeView(coordinator: coordinator)
                .navigationDestination(isPresented: $coordinator.isShowingSetup) {
                    SessionSetupView(coordinator: coordinator)
                }
                .navigationDestination(isPresented: $coordinator.isSessionActive) {
                    ActiveSessionView(coordinator: coordinator)
                }
        }
        .sheet(isPresented: $coordinator.isShowingPaywall) {
            PaywallView(coordinator: coordinator)
        }
    }
}
