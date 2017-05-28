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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func clickChiyoda() {
        openPdfImage(.chiyoda)
    }

    func openPdfImage(_ ward: PdfImageViewController.Ward) {
        let storyboard = self.storyboard
        let viewController = storyboard?.instantiateViewController(withIdentifier: "pdfImageVC") as! PdfImageViewController
        viewController.ward = ward
        show(viewController, sender: nil)
    }
}
