//
//  SettingsTableViewController.swift
//  LearnApp
//
//  Created by Radik Gazetdinov on 27.12.2021.
//

import UIKit

/// Контроллер для настроек игры
class SettingsTableViewController: UITableViewController {

    /// Нужен ли таймер
    @IBOutlet weak var switchTimer: UISwitch!
    
    /// Время игры
    @IBOutlet weak var timeGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
    }
    
    /// Изменить необходимость таймера в игре
    @IBAction func changeTimerState(_ sender: UISwitch) {
        Settings.shared.currentSettings.timerState = sender.isOn
    }
    
    /// Сбросить настройки к дефолтным
    @IBAction func resetSettings(_ sender: Any) {
        Settings.shared.resetSettings()
        loadSettings()
    }
    
    /// Загрузить настрйоки
    private func loadSettings() {
        timeGameLabel.text = "\(Settings.shared.currentSettings.timeForGame) сек"
        switchTimer.isOn = Settings.shared.currentSettings.timerState
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectTimeVC":
            if let vc = segue.destination as? SelectTimeViewController {
                vc.data = [10, 20, 30, 40]
            }
        default:
            break
        }
    }
}
