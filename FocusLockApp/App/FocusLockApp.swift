import SwiftUI

@main
struct FocusLockApp: App {
    @State private var coordinator = SessionCoordinator(
        blockingService: ScreenTimeAppBlockingService(),
        unlockService: StoreKitLifetimeUnlockService()
    )

    var body: some Scene {
        WindowGroup {
            RootView(coordinator: coordinator)
        }
    }
}
