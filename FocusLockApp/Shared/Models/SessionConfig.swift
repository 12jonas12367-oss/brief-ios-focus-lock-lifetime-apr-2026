import FamilyControls
import Foundation

struct SessionConfig {
    var durationMinutes: Int
    var activitySelection: FamilyActivitySelection

    static let `default` = SessionConfig(
        durationMinutes: 25,
        activitySelection: FamilyActivitySelection()
    )
}
