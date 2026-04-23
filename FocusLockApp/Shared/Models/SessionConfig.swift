import Foundation

struct SessionConfig: Equatable {
    var durationMinutes: Int
    var blockedApps: [String]
    var blockedCategories: [String]

    static let `default` = SessionConfig(
        durationMinutes: 25,
        blockedApps: ["Instagram", "YouTube"],
        blockedCategories: ["Social", "Games"]
    )
}
