//
//  TimeTableVC.swift
//  Sungatullin
//
//  Created by Булат Сунгатуллин on 26.02.2020.
//  Copyright © 2020 Булат Сунгатуллин. All rights reserved.
//

import UIKit

class TimeTableVC: UITableViewController {
    
    //MARK: VARS and SETUPS
    private let refreshContoll = UIRefreshControl()
    private let requestControll = RequestSessionController()
    private let modelControll = ModelController()
    
    fileprivate func setupTableViewController() {
        self.navigationItem.title = "Fitness Kit"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 170
    }
    
    fileprivate func refreshSetup() {
        self.tableView.refreshControl = refreshContoll
        refreshContoll.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
        refreshContoll.attributedTitle = NSAttributedString(string: "Fetching Weather Data ...")
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewController()
        refreshSetup()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {return 7}
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0: return "Понедельник"
            case 1: return "Вторник"
            case 2: return "Среда"
            case 3: return "Четверг"
            case 4: return "Пятница"
            case 5: return "Суббота"
            case 6: return "Воскресенье"
        default:
            return nil
        }
    }
    
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case section: return modelControll.getGetObjectFromRealm(section + 1).count
        default:
            return 1
        }
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        switch indexPath.row {
        case indexPath.row:
            cell.labelName.text = modelControll.getGetObjectFromRealm(indexPath.row + 1)[indexPath.row].name
            cell.timeLabel.text = "Время занятий: \(modelControll.getGetObjectFromRealm(indexPath.row + 1)[indexPath.row].startTime) - \(modelControll.getGetObjectFromRealm(indexPath.row + 1)[indexPath.row].endTime)"
            cell.placeLabel.text = "Зал: \(modelControll.getGetObjectFromRealm(indexPath.row + 1)[indexPath.row].place)"
            cell.teacherLabel.text = "Тренер: \(modelControll.getGetObjectFromRealm(indexPath.row + 1)[indexPath.row].teacher)"
            cell.descriptionText.text = "Описание: " + modelControll.getGetObjectFromRealm(indexPath.row + 1)[indexPath.row].descript
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

//MARK: extension class
extension TimeTableVC {
    
    @objc private func refreshAction(_ sender: Any) {
        self.refreshContoll.beginRefreshing()
        requestControll.getRequest(refControll: self.refreshContoll, vc: self)
    }
    
    
}
