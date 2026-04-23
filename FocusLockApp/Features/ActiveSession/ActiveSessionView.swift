import SwiftUI

struct ActiveSessionView: View {
    @Bindable var coordinator: SessionCoordinator

    var body: some View {
        VStack(spacing: 20) {
            Text("Focus Active")
                .font(.largeTitle.bold())

            Text(timeString)
                .font(.system(size: 48, weight: .heavy, design: .rounded))
                .monospacedDigit()

            Text(blockingSummary)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button("End Session") {
                coordinator.stopSession()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .navigationTitle("Active Session")
        .navigationBarBackButtonHidden(true)
    }

    private var blockingSummary: String {
        let selection = coordinator.currentConfig.activitySelection
        let appCount = selection.applicationTokens.count
        let categoryCount = selection.categoryTokens.count
        let webCount = selection.webDomainTokens.count

        if appCount == 0, categoryCount == 0, webCount == 0 {
            return "No Screen Time targets selected"
        }

        return "Blocking \(appCount) apps, \(categoryCount) categories, and \(webCount) websites"
    }

    private var timeString: String {
        let minutes = coordinator.secondsRemaining / 60
        let seconds = coordinator.secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
