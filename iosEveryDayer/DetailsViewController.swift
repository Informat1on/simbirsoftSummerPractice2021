//
//  DetailsViewController.swift
//  iosEveryDayer
//
//  Created by Арсений Щербак on 28.06.2021.
//  Copyright © 2021 Arseniy Shcherbak. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //массив всех событий
    var eventArray:[JSFile]=[]
    //индекс выбранной ячейки
    var cellIndex:Int!
    

    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet var eventDetailsView: UIView!
    
    //как только появляется экран - загружаю нужные данные
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //добавляю текст на экран
        eventTitleLabel.text = eventArray[cellIndex].name
        eventDateLabel.text = timeFormat(time: eventArray[cellIndex].date_start,time2: nil, formating: "dd.MM.yyyy")
        eventTimeLabel.text = timeFormat(time: eventArray[cellIndex].date_start,time2: eventArray[cellIndex].date_finish, formating: "HH:mm")
        eventDescriptionLabel.text = eventArray[cellIndex].eventDescription

    }
    
    //функция закрытия
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
}

//функция форматирования времени
func timeFormat(time:String,time2:String?,formating:String) -> String {
    var eventUnix = Double(time)!
    //получаю даты из событий
    var eventDate = NSDate(timeIntervalSince1970: eventUnix)
    //формат
    let format = DateFormatter()
    format.dateFormat = formating
    var formatedDate = format.string(from: eventDate as Date)
    if time2 == nil{
    
    }else{
        eventUnix = Double(time2!)!
        //получаю даты из событий
        eventDate = NSDate(timeIntervalSince1970: eventUnix)
        //формат
        formatedDate = formatedDate + " - " + format.string(from: eventDate as Date)
    }
    
    return formatedDate
}
