import Foundation

@MainActor
protocol LifetimeUnlockService {
    var isUnlocked: Bool { get }
    var lifetimePriceDisplay: String? { get }

    mutating func prepare() async
    mutating func purchaseLifetimeUnlock() async throws
    mutating func restorePurchases() async
}
