import Foundation
import StoreKit

@MainActor
final class StoreKitLifetimeUnlockService: LifetimeUnlockService {
    enum UnlockError: LocalizedError {
        case productNotFound
        case purchasePending
        case purchaseCancelled
        case unverifiedTransaction

        var errorDescription: String? {
            switch self {
            case .productNotFound:
                return "Purchase item unavailable right now"
            case .purchasePending:
                return "Purchase is pending approval"
            case .purchaseCancelled:
                return "Purchase cancelled"
            case .unverifiedTransaction:
                return "Purchase could not be verified"
            }
        }
    }

    private let productID: String
    private var cachedProduct: Product?

    private(set) var isUnlocked = false
    var lifetimePriceDisplay: String? { cachedProduct?.displayPrice }

    init(productID: String = "focus_lock_lifetime_unlock") {
        self.productID = productID
    }

    func prepare() async {
        await refreshProduct()
        await refreshEntitlements()
    }

    func purchaseLifetimeUnlock() async throws {
        if cachedProduct == nil {
            await refreshProduct()
        }

        guard let product = cachedProduct else {
            throw UnlockError.productNotFound
        }

        let purchaseResult = try await product.purchase()
        switch purchaseResult {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            if transaction.productID == productID {
                isUnlocked = true
            }
            await transaction.finish()
        case .pending:
            throw UnlockError.purchasePending
        case .userCancelled:
            throw UnlockError.purchaseCancelled
        @unknown default:
            throw UnlockError.purchaseCancelled
        }
    }

    func restorePurchases() async {
        do {
            try await AppStore.sync()
        } catch {
            // Ignore sync failure and still re-check current entitlements.
        }

        await refreshEntitlements()
    }

    private func refreshProduct() async {
        do {
            cachedProduct = try await Product.products(for: [productID]).first
        } catch {
            cachedProduct = nil
        }
    }

    private func refreshEntitlements() async {
        var unlocked = false

        for await entitlement in Transaction.currentEntitlements {
            guard let transaction = try? checkVerified(entitlement) else {
                continue
            }

            if transaction.productID == productID, transaction.revocationDate == nil {
                unlocked = true
                break
            }
        }

        isUnlocked = unlocked
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .verified(let value):
            return value
        case .unverified(_, _):
            throw UnlockError.unverifiedTransaction
        }
    }
}
