import Foundation

struct MockLifetimeUnlockService: LifetimeUnlockService {
    var isUnlocked: Bool = false

    mutating func purchaseLifetimeUnlock() async throws {
        // TODO: Wire StoreKit 2 Product.purchase() with product id "focus_lock_lifetime_unlock".
        isUnlocked = true
    }

    mutating func restorePurchases() async {
        // TODO: Restore with Transaction.currentEntitlements.
    }
}
