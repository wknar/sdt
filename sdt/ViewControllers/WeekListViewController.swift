//
//  WeekListViewController.swift
//  sdt
//
//  Created by Ara Wakana on 2018/07/28.
//  Copyright © 2018 wknar. All rights reserved.
//

import UIKit
import RealmSwift

class WeekListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    enum Week: Int {
        case sun
        case mon
        case tue
        case wed
        case thu
        case fri
        case sat

        static let count: Int = {
            var max: Int = 0
            while let _ = Week(rawValue: max) { max += 1 }
            return max
        }()
    }

    @IBOutlet weak var tableView: UITableView!

    var nameArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        loadList()
    }

    func loadList() {
        let realm = try! Realm()
        let garbage = realm.objects(Garbage.self)
        for i in 0..<garbage.count {
            nameArray.insert(garbage[i].content, at: i)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Week.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekCell") as! WeekCell
        cell.setup(week: Week(rawValue: indexPath.row)!, name: nameArray[indexPath.row])
        return cell
    }

}

class WeekCell: UITableViewCell {
    @IBOutlet weak var weekIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    func setup(week: WeekListViewController.Week, name: String) {
        titleLabel.text = name
        switch week {
        case .sun:
            weekIcon.image = UIImage(named: "sun_icon")
        case .mon:
            weekIcon.image = UIImage(named: "mon_icon")
        case .tue:
            weekIcon.image = UIImage(named: "tue_icon")
        case .wed:
            weekIcon.image = UIImage(named: "wed_icon")
        case .thu:
            weekIcon.image = UIImage(named: "thu_icon")
        case .fri:
            weekIcon.image = UIImage(named: "fri_icon")
        case .sat:
            weekIcon.image = UIImage(named: "sat_icon")
        }
    }

    override func awakeFromNib() {
        selectionStyle = .none
    }
}
