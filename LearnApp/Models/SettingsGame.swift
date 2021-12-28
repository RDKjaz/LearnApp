//
//  SettingsGame.swift
//  LearnApp
//
//  Created by Radik Gazetdinov on 27.12.2021.
//

import Foundation

/// Настройки игры
struct SettingsGame: Codable {
    
    /// Включен ли таймер
    var timerState: Bool
    
    /// Время на игру
    var timeForGame: Int
}


/// Настройки
class Settings {
    
    static var shared = Settings()
    
    /// Настройки по умолчанию
    let defaultSettings = SettingsGame(timerState: true, timeForGame: 30)
    
    /// Текущие настройки
    var currentSettings: SettingsGame {
        get {
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.settingsGame) as? Data {
                return try! PropertyListDecoder().decode(SettingsGame.self, from: data)
            }
            else {
                if let data = try? PropertyListEncoder().encode(defaultSettings) {
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
                }
                return defaultSettings
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
            }
        }
    }
    
    /// Установить настройки по умолчанию
    public func resetSettings() {
        currentSettings = defaultSettings
    }
}
