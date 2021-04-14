//
//  DigitekaLoadableView.swift
//  Digiteka
//
//  Created by Lucas on 14/04/2021.
//  Copyright © 2021 INGENOSYA SA. All rights reserved.
//

import UIKit

open class DigitekaLoadableView: UIView {

    var viewFromXib: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewFromXib = loadView()
        
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewFromXib = loadView()
    }
   
   public func loadView() -> UIView {
        let name = String(describing: type(of: self))
        if let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as? UIView {
            self.addSubview(view)
            view.frame = bounds
            view.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
            return view
        }else {
            return UIView()
        }
    }
}
