//
//  WebViewHelpersDelegate.swift
//  Digiteka
//
//  Created by Lucas on 14/04/2021.
//  Copyright © 2021 INGENOSYA SA. All rights reserved.
//

import Foundation


public protocol WebViewHelpersDelegate {
    func viewDidAutoPlayTopAsLeft()
    func viewDidAutoPlayTopAsRightDidScroll()
    func viewDidAutoPlayBottomAsLeft()
}