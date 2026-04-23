import FamilyControls
import SwiftUI

struct SessionSetupView: View {
    @Bindable var coordinator: SessionCoordinator

    @State private var durationMinutes = 25
    @State private var activitySelection = FamilyActivitySelection()
    @State private var isShowingActivityPicker = false

    var body: some View {
        Form {
            Section("Duration") {
                Stepper("\(durationMinutes) minutes", value: $durationMinutes, in: 5...120, step: 5)
            }

            Section("Blocked Items") {
                Text(summaryText)
                    .foregroundStyle(.secondary)

                Button("Choose Apps & Categories") {
                    isShowingActivityPicker = true
                }
            }

            Section {
                Button("Start Session") {
                    let config = SessionConfig(
                        durationMinutes: durationMinutes,
                        activitySelection: activitySelection
                    )
                    coordinator.saveSetup(config: config)
                    coordinator.startSession()
                }
            }
        }
        .navigationTitle("Session Setup")
        .onAppear {
            durationMinutes = coordinator.currentConfig.durationMinutes
            activitySelection = coordinator.currentConfig.activitySelection
        }
        .familyActivityPicker(isPresented: $isShowingActivityPicker, selection: $activitySelection)
    }

    private var summaryText: String {
        let appCount = activitySelection.applicationTokens.count
        let categoryCount = activitySelection.categoryTokens.count
        let webCount = activitySelection.webDomainTokens.count

        if appCount == 0, categoryCount == 0, webCount == 0 {
            return "No apps or categories selected yet"
        }

        return "\(appCount) apps, \(categoryCount) categories, \(webCount) websites selected"
    }
}
