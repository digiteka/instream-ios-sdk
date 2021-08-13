//
//  TopLeftV.swift
//  Digiteka
//
//  Created by INGENOSYA SA on 23/04/2021.
//  Copyright © 2021 INGENOSYA SA. All rights reserved.
//

import UIKit

class TopLeftV: UIView {

    
    @IBOutlet weak var sampleView: UIView!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        loadView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        loadView()
      
    }
    
    public func loadView(){
        
        //Bundle.main.loadNibNamed("TopLeftView", owner: self, options: nil)
        let bundle = Bundle(for: self.classForCoder)
        
        let nib = UINib(nibName: "TopLeftView", bundle: bundle)
        
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
        
    }

}
