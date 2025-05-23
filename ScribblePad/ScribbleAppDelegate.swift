import Foundation
import SwiftUI



// MARK: - App Delegate for Menu Handling
class ScribbleAppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusBarItem()
        
        // Set up to handle termination event
        NSApp.setActivationPolicy(.regular)
    }
    
    func setupStatusBarItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem?.button {
            //button.title = "S"
            //button.font = NSFont.boldSystemFont(ofSize: 15)
            let symbolConfig = NSImage.SymbolConfiguration(pointSize: 16, weight: .medium)
                    button.image = NSImage(systemSymbolName: "doc.circle", accessibilityDescription: "ScribblePad")?
                        .withSymbolConfiguration(symbolConfig)
            button.action = #selector(statusBarButtonClicked)
            button.target = self
        }
    }
    
    @objc func statusBarButtonClicked() {
        if let window = NSApp.windows.first {
            if window.isVisible {
                // If window is already visible, just bring it to front
                NSApp.activate(ignoringOtherApps: true)
                window.makeKeyAndOrderFront(nil)
            } else {
                // If window is hidden, make it visible and bring to front
                NSApp.setActivationPolicy(.regular)
                NSApp.activate(ignoringOtherApps: true)
                window.makeKeyAndOrderFront(nil)
            }
        } else {
            // If no window exists, make sure the app is active
            NSApp.setActivationPolicy(.regular)
            NSApp.activate(ignoringOtherApps: true)
        }
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        // When clicking on the dock icon
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
        
        if !flag {
            // If no visible windows, make the main window visible
            if let window = NSApp.windows.first {
                window.makeKeyAndOrderFront(nil)
            }
        }
        return true
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        // Prevent the app from terminating when the last window is closed
        return true
    }
}
