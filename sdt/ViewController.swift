//
//  ViewController.swift
//  sdt
//
//  Created by アラ 若菜 on 2017/02/16.
//  Copyright © 2017 wknar. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView = UIPickerView()

    @IBOutlet var dayButton1: UIButton?
    @IBOutlet var dayButton2: UIButton?
    @IBOutlet var contentLabel1: UILabel?
    @IBOutlet var contentLabel2: UILabel?
    @IBOutlet var contentLabel3: UILabel?
    @IBOutlet var contentLabel4: UILabel?
    @IBOutlet var contentLabel5: UILabel?
    @IBOutlet var contentLabel6: UILabel?
    @IBOutlet var contentLabel7: UILabel?

    let pickerList = ["燃えるゴミ", "燃えないゴミ", "プラスチックゴミ", "資源ゴミ", "ゴミ捨てなし"]
    var contentList = [String]()
    var day: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        if let pickerView = pickerView {
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.selectRow(2, inComponent: 0, animated: true)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setData()
    }

    @IBAction func dayButtonTapped1() {
        chanageDay(1)
    }
    @IBAction func dayButtonTapped2() {
        chanageDay(2)
    }
    @IBAction func dayButtonTapped3() {
        chanageDay(3)
    }
    @IBAction func dayButtonTapped4() {
        chanageDay(4)
    }
    @IBAction func dayButtonTapped5() {
        chanageDay(5)
    }
    @IBAction func dayButtonTapped6() {
        chanageDay(6)
    }
    @IBAction func dayButtonTapped7() {
        chanageDay(7)
    }

    func chanageDay(_ selectedDay: Int) {
        day = selectedDay
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch day {
        case 1:
            contentLabel1?.text = pickerList[row]
            contentList[0] = pickerList[row]
        case 2:
            contentLabel2?.text = pickerList[row]
            contentList[1] = pickerList[row]
        case 3:
            contentLabel3?.text = pickerList[row]
            contentList[2] = pickerList[row]
        case 4:
            contentLabel4?.text = pickerList[row]
            contentList[3] = pickerList[row]
        case 5:
            contentLabel5?.text = pickerList[row]
            contentList[4] = pickerList[row]
        case 6:
            contentLabel6?.text = pickerList[row]
            contentList[5] = pickerList[row]
        case 7:
            contentLabel7?.text = pickerList[row]
            contentList[6] = pickerList[row]
        default:
            return
        }
        saveGarbage(pickerList[row])
        AppDelegate().addWeeklyNotification(20, 0, contentList)
    }

    func saveGarbage(_ content: String) {
        let realm = try! Realm()
        let garbage = Garbage()
        garbage.day = day
        garbage.content = content

        try! realm.write() {
            realm.add(garbage, update: true)
        }
    }

    func setData() {
        let realm = try! Realm()
        let garbage = realm.objects(Garbage.self)
        if garbage.count > 0 {
            getGarbage()
        } else {
            createFirstData()
        }
        contentLabel1?.text = contentList[0]
        contentLabel2?.text = contentList[1]
        contentLabel3?.text = contentList[2]
        contentLabel4?.text = contentList[3]
        contentLabel5?.text = contentList[4]
        contentLabel6?.text = contentList[5]
        contentLabel7?.text = contentList[6]
    }

    func getGarbage() {
        let realm = try! Realm()
        let garbage = realm.objects(Garbage.self)
        for i in 0..<garbage.count {
            contentList.insert(garbage[i].content, at: i)
        }
    }

    func createFirstData() {
        let realm = try! Realm()
        try! realm.write() {
            realm.create(Garbage.self, value: [1, pickerList[0]])
            realm.create(Garbage.self, value: [2, pickerList[1]])
            realm.create(Garbage.self, value: [3, pickerList[2]])
            realm.create(Garbage.self, value: [4, pickerList[3]])
            realm.create(Garbage.self, value: [5, pickerList[4]])
            realm.create(Garbage.self, value: [6, pickerList[0]])
            realm.create(Garbage.self, value: [7, pickerList[1]])
        }
        getGarbage()
    }

}
