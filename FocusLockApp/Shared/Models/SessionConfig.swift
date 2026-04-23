import FamilyControls
import Foundation

struct SessionConfig {
    var durationMinutes: Int
    var activitySelection: FamilyActivitySelection

    @MainActor
    static let `default` = SessionConfig(
        durationMinutes: 25,
        activitySelection: FamilyActivitySelection()
    )
}
