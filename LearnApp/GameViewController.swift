//
//  GameViewController.swift
//  LearnApp
//
//  Created by Radik Gazetdinov on 11.11.2021.
//

import UIKit


/// Контроллер главного экрана
class GameViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Скрыть кнопку и распечатать title
    /// - Parameter sender: Кнопка
    @IBAction func touchButton(_ sender: UIButton) {
        sender.isHidden = true
        print(sender.currentTitle ?? "Title is nil")
    }
}
