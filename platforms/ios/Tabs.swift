import Foundation
import UIKit
import HotwireNative

extension HotwireTab {

    static let all: [HotwireTab] = {
        var tabs: [HotwireTab] = []

        if Demo.current == Demo.local {
            tabs.append(.navigation)
            tabs.append(.bridgeComponents)
        }

        return tabs
    }()

    // MARK: - Tabs

    static let navigation = HotwireTab(
        title: "Navigation",
        image: safeSymbol("arrow.left.arrow.right"),
        url: Demo.current
    )

    static let bridgeComponents = HotwireTab(
        title: "Bridge Components",
        image: {
            if #available(iOS 17.4, *) {
                return safeSymbol("widget.small", fallback: "square.grid.2x2")
            } else {
                return safeSymbol("square.grid.2x2")
            }
        }(),
        url: Demo.current.appendingPathComponent("components")
    )

    static let resources = HotwireTab(
        title: "Resources",
        image: {
            if #available(iOS 17.4, *) {
                return safeSymbol("questionmark.text.page", fallback: "book.closed")
            } else {
                return safeSymbol("book.closed")
            }
        }(),
        url: Demo.current.appendingPathComponent("resources")
    )

    static let bugsAndFixes = HotwireTab(
        title: "Bugs & Fixes",
        image: safeSymbol("ladybug", fallback: "ant"),
        url: Demo.current.appendingPathComponent("bugs")
    )
}

// MARK: - Safe SF Symbol Helper

private func safeSymbol(_ name: String, fallback: String = "questionmark") -> UIImage {
    return UIImage(systemName: name)
        ?? UIImage(systemName: fallback)
        ?? UIImage() // nunca nil → evita crash
}
