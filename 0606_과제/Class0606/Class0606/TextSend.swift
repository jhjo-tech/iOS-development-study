//
//  TextSend.swift
//  Class0606
//
//  Created by Jo JANGHUI on 2018. 6. 7..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit


protocol TextSendDelegate: class {
    func textSend()
}

class CoustomSendButton: UIButton {
    weak var delegate: TextSendDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("next", for: .normal)
        setTitleColor(.red, for: .normal)
        backgroundColor = .black
        addTarget(self, action: #selector(nextViewSendText), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func nextViewSendText () {
        delegate?.textSend()
    }

}
