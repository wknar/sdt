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

    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var dayButton1: UIButton?
    @IBOutlet var dayButton2: UIButton?
    @IBOutlet var dayButton3: UIButton?
    @IBOutlet var dayButton4: UIButton?
    @IBOutlet var dayButton5: UIButton?
    @IBOutlet var dayButton6: UIButton?
    @IBOutlet var dayButton7: UIButton?

    let pickerList = ["燃えるゴミ", "燃えないゴミ", "プラスチックゴミ", "資源ゴミ", "ゴミ捨てなし"]
    var contentList = [String]()
    var day: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ゴミ"
        if let pickerView = pickerView {
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.selectRow(2, inComponent: 0, animated: true)
        }
        descriptionLabel?.text = "クリックすると変更可能になります。"
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
        if let pickerView = pickerView, let index = getGarbageIndex(selectedDay) {
            pickerView.selectRow(index, inComponent: 0, animated: true)
        }
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
            dayButton1?.setTitle(pickerList[row], for: .normal)
            contentList[0] = pickerList[row]
        case 2:
            dayButton2?.setTitle(pickerList[row], for: .normal)
            contentList[1] = pickerList[row]
        case 3:
            dayButton3?.setTitle(pickerList[row], for: .normal)
            contentList[2] = pickerList[row]
        case 4:
            dayButton4?.setTitle(pickerList[row], for: .normal)
            contentList[3] = pickerList[row]
        case 5:
            dayButton5?.setTitle(pickerList[row], for: .normal)
            contentList[4] = pickerList[row]
        case 6:
            dayButton6?.setTitle(pickerList[row], for: .normal)
            contentList[5] = pickerList[row]
        case 7:
            dayButton7?.setTitle(pickerList[row], for: .normal)
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
            descriptionLabel?.text = "保存しました。20時にアラートが届きます。"
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.descriptionLabel?.text = "クリックすると変更可能になります。"
            }
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
        dayButton1?.setTitle(contentList[0], for: .normal)
        dayButton2?.setTitle(contentList[1], for: .normal)
        dayButton3?.setTitle(contentList[2], for: .normal)
        dayButton4?.setTitle(contentList[3], for: .normal)
        dayButton5?.setTitle(contentList[4], for: .normal)
        dayButton6?.setTitle(contentList[5], for: .normal)
        dayButton7?.setTitle(contentList[6], for: .normal)
    }

    func getGarbage() {
        let realm = try! Realm()
        let garbage = realm.objects(Garbage.self)
        for i in 0..<garbage.count {
            contentList.insert(garbage[i].content, at: i)
        }
    }

    func getGarbageIndex(_ day: Int) -> Int? {
        let realm = try! Realm()
        if let garbage = realm.objects(Garbage.self).filter("day == \(day)").first, let index = pickerList.index(of: garbage.content) {
            return index
        }
        return nil
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
