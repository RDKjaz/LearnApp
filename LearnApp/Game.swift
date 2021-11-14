//
//  Game.swift
//  LearnApp
//
//  Created by Radik Gazetdinov on 14.11.2021.
//

import Foundation

/// Класс игры
public class Game {
    
    /// Модель кнопки
    struct Item {
        /// Надпись
        var title:String
        /// Найдено ли число
        var isFound:Bool = false
    }
    
    /// Массив чисел
    private let data:[Int] = Array(1...99)
    
    /// Массив  модели кнопок
    var items:[Item] = []
    
    /// Количество кнопок
    private var countItems:Int
    
    var nextItem:Item?
    var status:StatusGame = .start
    
    init(countItems:Int) {
        self.countItems = countItems
        setupGame()
    }
    
    /// Сконфигурировать игру
    private func setupGame(){
        var digits = data.shuffled()
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
    }
    
    /// Проверить нажатую кнопки и сравнить
    /// - Parameter index: Индекс кнопки
    public func check(index:Int){
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        }
        
        if nextItem == nil {
            status = .win
        }
    }
}
