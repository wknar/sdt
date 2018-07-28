//
//  WardListViewController.swift
//  sdt
//
//  Created by アラ 若菜 on 2017/05/07.
//  Copyright © 2017 wknar. All rights reserved.
//

import Foundation
import UIKit

class WardListViewController: UIViewController {

    enum Ward: String {
        case chiyoda
        case bunkyo
        case setagaya
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "区ごとの分別表"
    }

    @IBAction func clickChiyoda() {
        openPdfImage(.chiyoda)
    }

    @IBAction func clickBunkyo() {
        openPdfImage(.bunkyo)
    }

    @IBAction func clickSetagaya() {
        openPdfImage(.setagaya)
    }

    func openPdfImage(_ ward: Ward) {
        let viewController = WebViewController()
        viewController.ward = ward
        navigationController?.pushViewController(viewController, animated: true)
    }
}
