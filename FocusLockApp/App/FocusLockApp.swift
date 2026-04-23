import SwiftUI

@main
struct FocusLockApp: App {
    @State private var coordinator = SessionCoordinator(
        blockingService: MockAppBlockingService(),
        unlockService: MockLifetimeUnlockService()
    )

    var body: some Scene {
        WindowGroup {
            RootView(coordinator: coordinator)
        }
    }
}
