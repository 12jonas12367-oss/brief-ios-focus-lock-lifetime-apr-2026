import Foundation

protocol AppBlockingService {
    var isEnforcementAvailable: Bool { get }
    func requestAuthorization() async -> Bool
    func startBlocking(config: SessionConfig) async throws
    func stopBlocking() async
}
