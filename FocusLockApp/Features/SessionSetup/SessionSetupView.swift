import SwiftUI

struct SessionSetupView: View {
    @Bindable var coordinator: SessionCoordinator

    @State private var durationMinutes = 25
    @State private var blockedApps = "Instagram, YouTube"
    @State private var blockedCategories = "Social, Games"

    var body: some View {
        Form {
            Section("Duration") {
                Stepper("\(durationMinutes) minutes", value: $durationMinutes, in: 5...120, step: 5)
            }

            Section("Blocked Apps") {
                TextField("Comma-separated", text: $blockedApps)
            }

            Section("Blocked Categories") {
                TextField("Comma-separated", text: $blockedCategories)
            }

            Section {
                Button("Start Session") {
                    let config = SessionConfig(
                        durationMinutes: durationMinutes,
                        blockedApps: splitCSV(blockedApps),
                        blockedCategories: splitCSV(blockedCategories)
                    )
                    coordinator.saveSetup(config: config)
                    coordinator.startSession()
                }
            }
        }
        .navigationTitle("Session Setup")
    }

    private func splitCSV(_ value: String) -> [String] {
        value
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}
