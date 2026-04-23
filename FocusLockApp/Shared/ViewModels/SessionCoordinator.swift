import Foundation

@Observable
@MainActor
final class SessionCoordinator {
    var isShowingSetup = false
    var isShowingPaywall = false
    var isSessionActive = false

    var currentConfig = SessionConfig.default
    var secondsRemaining = 0
    var statusMessage = "Ready for a focused session"

    private let blockingService: AppBlockingService
    private var unlockService: LifetimeUnlockService
    private var countdownTask: Task<Void, Never>?

    init(blockingService: AppBlockingService, unlockService: LifetimeUnlockService) {
        self.blockingService = blockingService
        self.unlockService = unlockService
    }

    var isUnlocked: Bool {
        unlockService.isUnlocked
    }

    func openSetup() {
        isShowingSetup = true
    }

    func openPaywall() {
        isShowingPaywall = true
    }

    func saveSetup(config: SessionConfig) {
        currentConfig = config
        statusMessage = "Session updated"
    }

    func startSession() {
        countdownTask?.cancel()
        countdownTask = Task {
            let authorized = await blockingService.requestAuthorization()
            guard authorized else {
                statusMessage = "Screen Time authorization needed"
                return
            }

            do {
                try await blockingService.startBlocking(config: currentConfig)
                isSessionActive = true
                isShowingSetup = false
                secondsRemaining = max(currentConfig.durationMinutes, 1) * 60
                statusMessage = "Focus session running"
                await runCountdown()
            } catch {
                statusMessage = "Could not start blocking: \(error.localizedDescription)"
            }
        }
    }

    func stopSession() {
        countdownTask?.cancel()
        countdownTask = Task {
            await blockingService.stopBlocking()
            isSessionActive = false
            statusMessage = "Session ended"
        }
    }

    func purchaseLifetimeUnlock() {
        countdownTask = Task {
            do {
                try await unlockService.purchaseLifetimeUnlock()
                isShowingPaywall = false
                statusMessage = "Lifetime unlock active"
            } catch {
                statusMessage = "Purchase failed: \(error.localizedDescription)"
            }
        }
    }

    func restorePurchases() {
        countdownTask = Task {
            await unlockService.restorePurchases()
            statusMessage = unlockService.isUnlocked ? "Purchases restored" : "No purchases found"
        }
    }

    private func runCountdown() async {
        while secondsRemaining > 0 && !Task.isCancelled {
            try? await Task.sleep(for: .seconds(1))
            secondsRemaining -= 1
        }
        if secondsRemaining <= 0 {
            await blockingService.stopBlocking()
            isSessionActive = false
            statusMessage = "Focus complete"
        }
    }
}
