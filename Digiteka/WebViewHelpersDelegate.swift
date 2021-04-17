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
    func viewDidAutoPlayTopAsRightDidScroll()
    func viewDidAutoPlayBottomAsLeft()
    func hideDidScroll()
    func onScrollTopLeft(_ isHashShow : Bool, _ contentOffset: CGPoint)
    func onScrollTopRight(_ isHashShow : Bool, _ contentOffset: CGPoint)
    func onScrollBottomLeft(_ isHashShow : Bool, _ contentOffset: CGPoint)
    func onChangeScrollView(_ scrollView : UIScrollView)
}
