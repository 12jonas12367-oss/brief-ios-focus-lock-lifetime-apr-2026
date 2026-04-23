import XCTest
@testable import FocusLock

@MainActor
final class SessionCoordinatorTests: XCTestCase {
    func testStartSessionWhenAuthorizationDeniedSetsStatusMessage() async {
        let coordinator = SessionCoordinator(
            blockingService: BlockingServiceMock(authorized: false),
            unlockService: UnlockServiceMock()
        )

        coordinator.startSession()
        await waitUntil { coordinator.statusMessage == "Screen Time authorization needed" }

        XCTAssertEqual(coordinator.statusMessage, "Screen Time authorization needed")
        XCTAssertFalse(coordinator.isSessionActive)
    }

    func testPurchaseLifetimeUnlockClosesPaywallAndUpdatesStatus() async {
        let coordinator = SessionCoordinator(
            blockingService: BlockingServiceMock(authorized: true),
            unlockService: UnlockServiceMock()
        )

        coordinator.openPaywall()
        coordinator.purchaseLifetimeUnlock()
        await waitUntil { coordinator.statusMessage == "Lifetime unlock active" }

        XCTAssertTrue(coordinator.isUnlocked)
        XCTAssertFalse(coordinator.isShowingPaywall)
        XCTAssertEqual(coordinator.statusMessage, "Lifetime unlock active")
    }

    func testRestorePurchasesWithoutEntitlementSetsNoPurchaseMessage() async {
        let coordinator = SessionCoordinator(
            blockingService: BlockingServiceMock(authorized: true),
            unlockService: UnlockServiceMock(restoreUnlocked: false)
        )

        coordinator.restorePurchases()
        await waitUntil { coordinator.statusMessage == "No purchases found" }

        XCTAssertFalse(coordinator.isUnlocked)
        XCTAssertEqual(coordinator.statusMessage, "No purchases found")
    }

    private func waitUntil(
        timeoutTicks: Int = 80,
        condition: @escaping @MainActor () -> Bool
    ) async {
        for _ in 0..<timeoutTicks {
            if condition() { return }
            try? await Task.sleep(for: .milliseconds(10))
        }
    }
}

@MainActor
private final class BlockingServiceMock: AppBlockingService {
    private let authorized: Bool

    init(authorized: Bool) {
        self.authorized = authorized
    }

    var isEnforcementAvailable: Bool { true }

    func requestAuthorization() async -> Bool {
        authorized
    }

    func startBlocking(config: SessionConfig) async throws {
        _ = config
    }

    func stopBlocking() async {}
}

private struct UnlockServiceMock: LifetimeUnlockService {
    var isUnlocked = false
    var lifetimePriceDisplay: String? = "$7.99"
    var restoreUnlocked: Bool = false

    mutating func prepare() async {}

    mutating func purchaseLifetimeUnlock() async throws {
        isUnlocked = true
    }

    mutating func restorePurchases() async {
        isUnlocked = restoreUnlocked
    }
}
