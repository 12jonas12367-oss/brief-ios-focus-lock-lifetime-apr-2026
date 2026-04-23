import Foundation

struct MockLifetimeUnlockService: LifetimeUnlockService {
    var isUnlocked = false
    var lifetimePriceDisplay: String? = "$7.99"

    mutating func prepare() async {
        // No-op in mock mode.
    }

    mutating func purchaseLifetimeUnlock() async throws {
        isUnlocked = true
    }

    mutating func restorePurchases() async {
        // No-op in mock mode.
    }
}
