import Foundation

protocol LifetimeUnlockService {
    var isUnlocked: Bool { get }
    mutating func purchaseLifetimeUnlock() async throws
    mutating func restorePurchases() async
}
