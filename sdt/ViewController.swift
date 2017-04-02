//
//  ViewController.swift
//  sdt
//
//  Created by アラ 若菜 on 2017/02/16.
//  Copyright © 2017 wknar. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet var timePicker: UIDatePicker?

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        readAlert()
    }

    func readAlert() {
        let realm = try! Realm()
        let alert = realm.objects(Alert.self)
    }

    func saveAlert(_ hour: Int, _ minute: Int) {
        let realm = try! Realm()
        let alert = Alert()
        alert.title = "title dayo"
        alert.desc = "description dayo"
        alert.hour = hour
        alert.minute = minute

        try! realm.write() {
            realm.add(alert, update: true)
            showSavedAlert()
            AppDelegate().addWeeklyNotification(hour, minute)
        }
    }

    func showSavedAlert() {
        let alert = UIAlertController(title: "", message: "保存しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func okButtonAction() {
        print("*** tapped")
        let df = DateFormatter()
        df.locale = Locale(identifier: "ja_JP")
        df.dateFormat = "HH:mm"

        if let time = timePicker?.date {
            let changeTime = df.string(from: time).components(separatedBy: ":")
            if let hour = Int(changeTime[0]), let minute = Int(changeTime[1]) {
                saveAlert(hour, minute)
            }
        }
    }

}
