import FamilyControls
import Foundation
import ManagedSettings

@MainActor
final class ScreenTimeAppBlockingService: AppBlockingService {
    private let authorizationCenter: AuthorizationCenter
    private let settingsStore: ManagedSettingsStore

    init(
        authorizationCenter: AuthorizationCenter = .shared,
        settingsStore: ManagedSettingsStore = ManagedSettingsStore()
    ) {
        self.authorizationCenter = authorizationCenter
        self.settingsStore = settingsStore
    }

    var isEnforcementAvailable: Bool { true }

    func requestAuthorization() async -> Bool {
        do {
            try await authorizationCenter.requestAuthorization(for: .individual)
            return true
        } catch {
            return false
        }
    }

    func startBlocking(config: SessionConfig) async throws {
        let selection = config.activitySelection
        settingsStore.shield.applications = selection.applicationTokens.isEmpty ? nil : selection.applicationTokens
        settingsStore.shield.applicationCategories = selection.categoryTokens.isEmpty
            ? nil
            : .specific(selection.categoryTokens, except: Set<ApplicationToken>())
        settingsStore.shield.webDomains = selection.webDomainTokens.isEmpty ? nil : selection.webDomainTokens
    }

    func stopBlocking() async {
        settingsStore.shield.applications = nil
        settingsStore.shield.applicationCategories = nil
        settingsStore.shield.webDomains = nil
    }
}
