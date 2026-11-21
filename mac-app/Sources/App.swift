import SwiftUI
import AppKit

@main
public struct KNOTApp: App {
    public init() {
        NSApplication.shared.setActivationPolicy(.regular)
    }
    
    public var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.titleBar)
        .windowToolbarStyle(.unified)
        .defaultSize(width: 1040, height: 720)
    }
}
