//
//  ViewController.swift
//  sdt
//
//  Created by アラ 若菜 on 2017/02/16.
//  Copyright © 2017 wknar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var uppLbl:     UILabel?
    var rowLbl:     UILabel?

    var garbBag =   UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // set tags in each views
        self.uppLbl?.tag  = 0
        self.rowLbl?.tag  = 1
        self.garbBag.tag = 2

        initView()
    }

    func initView() {
        self.garbBag.image = UIImage(named: "garbageBag3.png")
        self.garbBag.frame = viewFrames(tag: self.garbBag.tag)
       self.view.addSubview(self.garbBag)
    }

    func viewFrames(tag: Int) -> CGRect {
        let screenSize: CGRect = UIScreen.main.bounds
        switch tag {
        case 0:
            break
        case 1:
            break
        case 2:
            return CGRect(x: screenSize.width/2-50, y: screenSize.height/2-50, width: 100, height: 100)
        default: return CGRect.zero
        }
        return CGRect.zero
    }

}

