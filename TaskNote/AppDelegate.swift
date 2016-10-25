//
//  AppDelegate.swift
//  TaskNote
//
//  Created by Tom Burns on 2016-10-24.
//  Copyright © 2016 BurnsMod. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	var statusItem: NSStatusItem!
	let key = "TaskNoteValue"
	let defaultNote = "TaskNote is empty"

	private var note: String {
		get {
			return UserDefaults.standard.string(forKey: key) ?? defaultNote
		}

		set {
			UserDefaults.standard.set(newValue, forKey: key)
			updateTitle()
		}
	}

	private func updateTitle() {
		statusItem.title = note
	}

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		self.statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
		updateTitle()
		createMenu()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
	}

	func editNotePressed(sender: NSMenuItem) {
		let alert = NSAlert()
		let input = NSTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 24))
		alert.messageText = "Enter new taskbar note"
		input.stringValue = note
		alert.accessoryView = input

		alert.addButton(withTitle: "Ok")
		alert.addButton(withTitle: "Cancel")
		switch(alert.runModal()) {
		case NSAlertFirstButtonReturn:
			note = input.stringValue
		default:
			break
		}
	}

	func quit(sender: NSMenuItem) {
		exit(0)
	}

	private func createMenu() {
		let menu = NSMenu()

		let editNoteItem = NSMenuItem(title: "Edit Note", action: #selector(editNotePressed(sender:)), keyEquivalent: "e")
		editNoteItem.target = self
		menu.addItem(editNoteItem)

		menu.addItem(NSMenuItem.separator())

		let quitItem = NSMenuItem(title: "Quit TaskNote", action: #selector(quit(sender:)), keyEquivalent: "q")
		quitItem.target = sel
		menu.addItem(quitItem)

		statusItem.menu = menu
	}
}

