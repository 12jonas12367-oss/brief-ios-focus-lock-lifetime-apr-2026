import Foundation

struct MockAppBlockingService: AppBlockingService {
    var isEnforcementAvailable: Bool { true }

    func requestAuthorization() async -> Bool {
        true
    }

    func startBlocking(config: SessionConfig) async throws {
        _ = config
        // Mock mode intentionally does not apply system shields.
    }

    func stopBlocking() async {
        // Mock mode intentionally does nothing.
    }
}
