//
//  WeekListViewController.swift
//  sdt
//
//  Created by Ara Wakana on 2018/07/28.
//  Copyright © 2018 wknar. All rights reserved.
//

import UIKit

class WeekListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    enum Week: Int {
        case sun
        case mon
        case tue
        case wed
        case thu
        case fri
        case sat
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekCell") as! WeekCell
        cell.setup(week: Week(rawValue: indexPath.row)!, name: "okome") // TODO: add text from database
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
    }
}
