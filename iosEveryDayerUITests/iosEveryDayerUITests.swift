//
//  iosEveryDayerUITests.swift
//  iosEveryDayerUITests
//
//  Created by Арсений Щербак on 29.06.2021.
//  Copyright © 2021 Arseniy Shcherbak. All rights reserved.
//

import XCTest

class iosEveryDayerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //функция тестирования добавления события
    func testAdding(){
        let app = XCUIApplication()
        //запускаю приложение
        app.launch()
        
        //нажимаю на кнопку добавления
        app.windows.buttons["add"].tap()
        
        //нажимаю на ввод названия
        app.textViews["Название"].tap()
        //ввожу
        app.textViews["Название"].typeText("Купить картошку")
        //закрываю ввод
        app.toolbars.buttons["Готово"].tap()
        
        
        //нажимаю на ввод подробностей
        app.textViews["Описание"].tap()
        //ввожу
        app.textViews["Описание"].typeText("Сходить в магнит и купить 3 кг картошки")
        //закрываю ввод
        app.toolbars.buttons["Готово"].tap()
        
        //нажимаю на добавить
        app.windows.buttons["plus"].tap()
        //нажимаю на обновить
        app.windows.buttons["Button"].tap()
        //текст должен быть такой, тк лейбл "название" не удаляется
        XCTAssert(app.cells.staticTexts["Купить картошкуНазвание"].exists)
                
        //ввожу все данные
        //        app.windows.textViews[""]
                        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
