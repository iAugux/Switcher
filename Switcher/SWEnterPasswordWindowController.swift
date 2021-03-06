//
//  SWEnterPasswordWindowController.swift
//  Switcher
//
//  Created by X140Yu on 6/9/16.
//  Copyright © 2016 X140Yu. All rights reserved.
//

import Cocoa

enum SWLoginType {
    case None
    case AppStore
    case iTunes
}

class SWEnterPasswordWindowController: NSWindowController {

    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var prompotTextField: NSTextField!
    var userName = ""
    var password = ""
    var loginType = SWLoginType.None
    
    override func windowDidLoad() {
        super.windowDidLoad()
        prompotTextField.stringValue = "Enter password for \(userName)"
        passwordTextField.stringValue = password
    }

    @IBAction func SignIn(sender: NSButton) {
        let password = passwordTextField.stringValue
        if password != "" {
            SWAccountManager.sharedInstance.save(password, with: userName)
            window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseOK)
            switch loginType {
            case .AppStore:
                SWAppLoginManager.loginAppStoreWith(userName, password: password)
            case .iTunes:
                SWAppLoginManager.loginiTnesWith(userName, password: password)
            default: break
            }
        }
    }

    @IBAction func cancel(sender: NSButton) {
        window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseCancel)
    }
}
