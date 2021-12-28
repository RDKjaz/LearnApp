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
    public struct Item {
        /// Надпись
        var title: String
        
        /// Найдено ли число
        var isFound: Bool = false
        
        /// Сделана ли ошибка
        var isError: Bool = false
    }
    
    /// Массив  кнопок c цифрами для игры
    public var items: [Item] = []
    
    /// Количество кнопок
    private var countItems: Int
    
    /// Следующее число, которое нужно найти
    public var nextItem: Item?
    
    ///Новый ли рекорд
    public var isNewRecord: Bool = false
    
    /// Статус игры
    public var status: StatusGame = .start{
        didSet{
            if status != .start {
                if status == .win && Settings.shared.currentSettings.timerState {
                    let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
                    
                    if record == 0 || secondsGame < record {
                        UserDefaults.standard.setValue(secondsGame, forKey: KeysUserDefaults.recordGame)
                        isNewRecord = true
                    }
                }
                stopGame()
            }
        }
    }
    
    /// Время для игры
    private var timeForGame: Int
    
    /// Потраченное время на игру
    private var secondsGame: Int{
        didSet{
            if secondsGame == 0 {
                status = .lose
            }
            updateTimer(status, secondsGame)
        }
    }
    
    /// Таймер
    private var timer:Timer?
    
    /// Обновить таймер
    private var updateTimer: (StatusGame,Int)->()
    
    /// Инициализатор
    /// - Parameters:
    ///   - countItems: Количество кнопок
    ///   - updateTimer: Обновление таймера
    init(countItems:Int, updateTimer:@escaping (_ status:StatusGame, _ seconds:Int)->()) {
        self.countItems = countItems
        self.timeForGame = Settings.shared.currentSettings.timeForGame
        self.secondsGame = self.timeForGame
        self.updateTimer = updateTimer
        setupGame()
    }
    
    /// Сконфигурировать игру перед началом
    private func setupGame(){
        isNewRecord = false
        
        var digits = Array(1...99).shuffled()
        
        items.removeAll()
        
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        
        updateTimer(status, secondsGame)
        
        if Settings.shared.currentSettings.timerState {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](_) in
                self?.secondsGame -= 1
            })
        }
    }
    
    /// Начать новую игру
    public func newGame(){
        status = .start
        self.secondsGame = self.timeForGame
        setupGame()
    }
    
    /// Проверить нажатую кнопку и сравнить с заданным числом
    /// - Parameter index: Индекс кнопки
    public func check(index: Int) {
        guard status == .start else {return}
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        }
        else {
            items[index].isError = true
        }
        
        if nextItem == nil {
            status = .win
        }
    }
    
    /// Остановить игру
    public func stopGame(){
        timer?.invalidate()
    }
}


extension Int {
    
    /// Перевести секунды в строку
    /// - Returns: Строку с оставшимися секундами
    public func secondsToString()->String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
