//
//  RecordViewController.swift
//  LearnApp
//
//  Created by Radik Gazetdinov on 27.12.2021.
//

import UIKit

/// Контроллер для отображения модального окна с рекордом
class RecordViewController: UIViewController {
    
    /// Рекорд
    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        
        recordLabel.text = record != 0
        ? "Ваш рекорд \(record)"
        : "Рекорд не установлен"
    }
} 
