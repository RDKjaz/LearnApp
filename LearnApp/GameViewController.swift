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
    @IBOutlet weak var statusGame: UILabel!
    @IBOutlet weak var nextDigit: UILabel!
    
    lazy var game = Game(countItems: buttons.count)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setupScreen()
    }
    
    /// Скрыть кнопку и распечатать title
    /// - Parameter sender: Кнопка
    @IBAction func touchButton(_ sender: UIButton){
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index: buttonIndex)
        updateScreen()
    }
    
    /// Настрйока экрана
    private func setupScreen(){
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isHidden = false
        }
        
        nextDigit.text = game.nextItem?.title
    }
    
    /// Обновление экрана
    private func updateScreen(){
        for index in game.items.indices {
            buttons[index].isHidden = game.items[index].isFound
        }
        
        nextDigit.text = game.nextItem?.title
            
        if game.status == .win {
            statusGame.text = "Вы выиграли"
            statusGame.textColor = .green
        }
    }
}
