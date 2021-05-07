//
//  WebViewHelpersDelegate.swift
//  Digiteka
//
//  Created by Lucas on 14/04/2021.
//  Copyright © 2021 INGENOSYA SA. All rights reserved.
//

import Foundation
import UIKit

public protocol WebViewHelpersDelegate {
    func viewDidAutoPlayTopAsLeft()
    func viewDidAutoPlayTopAsRight()
    func viewDidAutoPlayBottomAsLeft()
    func viewDidAutoPlayBottomAsRight()
    func hideDidScroll()
    
}
