import Foundation

struct MockAppBlockingService: AppBlockingService {
    var isEnforcementAvailable: Bool { true }

    func requestAuthorization() async -> Bool {
        true
    }

    func startBlocking(config: SessionConfig) async throws {
        _ = config
        // TODO: Replace with FamilyControls/ManagedSettings integration on iOS runtime.
    }

    func stopBlocking() async {
        // TODO: Disable ManagedSettings shields here when real integration is added.
    }
}
