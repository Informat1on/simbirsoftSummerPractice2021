//
//  ViewController.swift
//  iosEveryDayer
//
//  Created by Арсений Щербак on 24.06.2021.
//  Copyright © 2021 Arseniy Shcherbak. All rights reserved.
//

import UIKit
import RealmSwift

// Get the default Realm
let realm = try! Realm()

class ViewController: UIViewController, UITableViewDelegate {
    
    //массив для работы с "хорошими событиями" - события, которые подходят под выбранную дату
    var goodEvents:[JSFile] = []
    //индекс выбранной строки для детального обзора
    var selectedIndex = 0
    //результат - база данных, с которой можно работать
    //обновляется каждый раз, когда к нему обращаются
    var eventsArray:Results<JSFile>!

    @IBAction func addButtonPressed(_ sender: UIButton) {
//        print("Button is pressed")
        //перехожу на окно добавления
        performSegue(withIdentifier: "goAdd", sender: self)
        
    }
    //view таблицы
    @IBOutlet weak var thingsTableView: UITableView!
    //view календаря
    @IBOutlet weak var calendarView: UIDatePicker!
    //refreshButton pressed
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        //обновляю события (может быть добавлено)
        getEvents(date: calendarView.date)
    }
    
    
    //функция вызывается каждый раз при выборе даты
    @IBAction func calendarViewAction(_ sender: UIDatePicker) {
        //текущая полная дата
        let fullDate = sender.date
        //функция обработки json,получения всех событий по дню
        getEvents(date: fullDate)
        //парсинг всех имеющися в json
    }
    
    //ф-ия при загрузке
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //загружаю информацию из бд
        eventsArray = realm.objects(JSFile.self)
        
        //благодаря этому появляются ячейки
        thingsTableView.delegate = self
        thingsTableView.dataSource = self
        
        //делаем красивый tableView
        //убираем линии
        thingsTableView.separatorStyle = .none
        //убираем полосу прокрутки
        thingsTableView.showsVerticalScrollIndicator = false
        
        //загружаю список дел на сегодня, если есть
        getEvents(date: calendarView.date)
    }

    
    //функция нахождения всех событий по указанной дате
    func getEvents(date:Date) {
        
        //очищаю все перед показом
        self.goodEvents.removeAll()
        thingsTableView.reloadData()

        //получить текущую дату (год,месяц,день) отдельно
        
        //год
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        //месяц
        format.dateFormat = "MM"
        let currentMonth = format.string(from: date)
        
        //день
        format.dateFormat = "dd"
        let currentDay = format.string(from: date)
        
        
//        print("Current date is \(currentDay). Current month is \(currentMonth). Current year is \(currentYear)")
        
        //перебор событий
        for event in eventsArray{
            //анализирую и получаю даты:
            
            //год
            let eventYear = timeFormat(time: event.date_start, time2: nil, formating: "yyyy")
            //месяц
            let eventMonth = timeFormat(time: event.date_start, time2: nil, formating: "MM")
            //день
            let eventDay = timeFormat(time: event.date_start, time2: nil, formating: "dd")
            
//            print("Event day is \(eventDay)")
            //если год,месяц,день подходят
            guard eventYear == currentYear else {continue}
            guard eventMonth == currentMonth else {continue}
            guard eventDay == currentDay else {continue}
            
            //то сохраняем событие в массив
            //ЦИКЛ РАБОТАЕТ !
            self.goodEvents.append(event)
            
//            print("Good events are \(self.goodEvents)")
        }
        
        //если не пустой массив
        if !self.goodEvents.isEmpty{
//            print("there is some events - \(self.goodEvents)")
            print("there is some events - \(self.goodEvents.count) for day \(currentDay)")
            thingsTableView.reloadData()
            //очищаю массив после действий, чтобы не выводило неправильно
            
            //делаем рефреш и вывод
        //если пустой массив - показываем, что дел нет на выбранный день
        }else{
            print("there is no events for chosen day - \(currentDay)")
            thingsTableView.reloadData()
        }
    }
    }


extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //возвращает количество задач на конкретный день
        //каждый раз должно вызываться при нажатии на дату
        return self.goodEvents.count
    }
    
    //отработка нажатия на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath) as? ThingsCell) != nil {
            //сохраняю в переменную id выбранной ячейки
            self.selectedIndex = indexPath.row
            
//            print("set new value for index from \(self.selectedIndex) to \(indexPath.row)")
            
            //при нажатии на ячейку начинаем перееход
            performSegue(withIdentifier: "goDetails", sender: self)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetails"{
            //вью контроллер назначения
            let destinationVC = segue.destination as! DetailsViewController
            //кладу в его переменные значения
            
            destinationVC.eventArray = self.goodEvents
            destinationVC.cellIndex = self.selectedIndex
            
//            print("added index to VC \(selectedIndex)")
        }
    }
    
    func  tableView(_ tableView: UITableView,cellForRowAt indexPath:IndexPath)-> UITableViewCell{
        //возвращает задачи на конкретный день
        //каждый раз должно вызываться при нажатии на дату
        
        //ячейка
        let cell = thingsTableView.dequeueReusableCell(withIdentifier: "timingCell") as! ThingsCell
        
        
        if !goodEvents.isEmpty{
        
        //описание ячейки
        let description = self.goodEvents[indexPath.row].name
        //время в ячейке (изначально String). Нужно получить только часы с каждой
        let timingStart = self.goodEvents[indexPath.row].date_start
        let startHour = timeFormat(time: timingStart, time2: nil, formating: "HH:mm")
        let timingEnd = self.goodEvents[indexPath.row].date_finish
        let endHour = timeFormat(time: timingEnd, time2: nil, formating: "HH:mm")
        
        //добавляю описание ячейке
        cell.thingDescriptionView.text = description
        cell.thingTimeView.text = "\(startHour) - \(endHour)"
            
        //округляю ячейку
        cell.thingView.layer.cornerRadius = cell.thingView.frame.height / 4
            
        }else{
            print("events is empty")
        }
        
        //показываю ячейку
        return cell
    }
    
    
}
