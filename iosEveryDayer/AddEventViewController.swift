//
//  AddEventViewController.swift
//  iosEveryDayer
//
//  Created by Арсений Щербак on 29.06.2021.
//  Copyright © 2021 Arseniy Shcherbak. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UITextViewDelegate {
    var placeholderLabel : UILabel!
    var placeholderLabel1 : UILabel!
    
    //объявления
    
    @IBOutlet weak var addDate: UIDatePicker!
    @IBOutlet weak var addEndHour: UIDatePicker!
    @IBOutlet weak var addName: UITextView!
    @IBOutlet weak var addDescription: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //добавляю кнопку Готово на клавиватуру
        addDescription.addDoneButtonOnKeyboard()
        addName.addDoneButtonOnKeyboard()
    }
    

    
    //функция закрытия
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func addButtonConfirm(_ sender: UIButton) {

        //добавляю все в бд
        addToDB(id: 1, date_start: "\(addDate.date.timeIntervalSince1970)", date_end: "\(addEndHour.date.timeIntervalSince1970)", name: "\(addName.text!)", description: "\(addDescription.text!)")
        //заново произвести проверку на данные
        //после добавления нужно обновить таблицу
        //закрываю вплывший ViewController
        close()
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    

//функция добавления в БД
func addToDB(id:Int,date_start:String,date_end:String,name:String,description:String){
    //добавляю все в бд
    let value = JSFile(value: [id,"\(date_start)","\(date_end)","\(name)","\(description)"])
    // Persist your data easily
    try! realm.write {
        realm.add(value)
    }
}
}


//добавляет кнопку "Готово" на клавиатуру. Код не мой - нашел с трудом в интернете, тк мои знания еще не позволяют придумать самому
extension UITextView{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
