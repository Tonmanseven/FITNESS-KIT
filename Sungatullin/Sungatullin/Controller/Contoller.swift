//
//  Contoller.swift
//  Sungatullin
//
//  Created by Булат Сунгатуллин on 27.02.2020.
//  Copyright © 2020 Булат Сунгатуллин. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

//MARK: работа с сетевыми запросами
class RequestSessionController {
    
    var sportsArray = [Sports]()
    private let fitnessUrl = "https://sample.fitnesskit-admin.ru/schedule/get_group_lessons_v2/1/"
    private var modelcontrollObject = ModelController()
    
    func getRequest(refControll: UIRefreshControl, vc: UITableViewController) {
        
        Alamofire.request(fitnessUrl, method: .get).responseJSON { response in
            guard response.result.isSuccess else {

                self.returnErrorConnection(err: response.result.error!, refContrl: refControll, viewc: vc)
                return
                }
            guard let arrayOfItems = response.result.value as? [[String: AnyObject]]
                else { print("Не могу перевести в массив"); return }
            
            for item in arrayOfItems {
                let daySportItem = Sports(name: item["name"] as! String,
                                          startTime: item["startTime"] as! String,
                                          endTime: item["endTime"] as! String,
                                          teacher: item["teacher"] as! String,
                                          place: item["place"] as! String,
                                          descript: item["description"] as! String,
                                          weekDay: item["weekDay"] as! Int)
                
                self.sportsArray.append(daySportItem)
                refControll.endRefreshing()
            }
            
            self.modelcontrollObject.writeNewItem(sport: self.sportsArray)
            DispatchQueue.main.async {
                vc.tableView.reloadData()
            }
            
        }
    }
    
    
    func returnErrorConnection(err: Error, refContrl: UIRefreshControl, viewc: UIViewController) {
        
        let alertController = UIAlertController(title: "Ошибка Интернет Соединения", message: "Проверьте соединение с интернетом", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        
        if err.localizedDescription == "The Internet connection appears to be offline." {
            DispatchQueue.main.async {
                viewc.present(alertController, animated: true)
            }
            refContrl.endRefreshing()
        }
    }
    
    
    
}


//MARK: работа с моделью
class ModelController {
    
    let realm = try! Realm()
    
    lazy var values: Results<SportWeekModel> = { realm.objects(SportWeekModel.self) }()
    
    //MARK: создаем новую запись
    func writeNewItem(sport: [Sports]) {
        print(realm.objects(SportWeekModel.self))
       
        try! realm.write {
            
            if realm.objects(SportWeekModel.self).isEmpty {
                for item in sport {
                    let sportsModel = SportWeekModel()
                    sportsModel.name = item.name
                    sportsModel.startTime = item.startTime
                    sportsModel.endTime = item.endTime
                    sportsModel.place = item.place
                    sportsModel.teacher = item.teacher
                    sportsModel.weekDay = item.weekDay
                    sportsModel.descript = item.descript
                    realm.add([sportsModel])
                }
            } else {
                for item in sport {
                    let object = realm.objects(SportWeekModel.self).filter(NSPredicate(format: "name = '\(item.name)' AND startTime = '\(item.startTime)' AND endTime = '\(item.endTime)' AND place = '\(item.place)' AND teacher = '\(item.teacher)' AND weekDay = \(item.weekDay) AND descript = '\(item.descript)'"))
                    object.setValue(item.name, forKey: "name")
                    object.setValue(item.startTime, forKey: "startTime")
                    object.setValue(item.endTime, forKey: "endTime")
                    object.setValue(item.place, forKey: "place")
                    object.setValue(item.teacher, forKey: "teacher")
                    object.setValue(item.weekDay, forKey: "weekDay")
                    object.setValue(item.descript, forKey: "descript")
                }
            }
            
        }
    }

    
    func getGetObjectFromRealm(_ section: Int) -> Results<SportWeekModel> {
        let predicate = NSPredicate(format: "weekDay == \(section)")
        let objects = values.filter(predicate)
        return objects
    }


}

