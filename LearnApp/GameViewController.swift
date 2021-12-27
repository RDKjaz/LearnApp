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
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    lazy var game = Game(countItems: buttons.count) { [weak self](status, time) in
        guard let self = self else {return}
        self.timerLabel.text = time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setupScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        game.stopGame()
    }
    
    /// Скрыть кнопку и распечатать title
    /// - Parameter sender: Кнопка
    @IBAction func touchButton(_ sender: UIButton){
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index: buttonIndex)
        updateScreen()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    /// Настрйока экрана
    private func setupScreen(){
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        
        timerLabel.isHidden = !Settings.shared.currentSettings.timerState
        nextDigit.text = game.nextItem?.title
    }
    
    /// Обновление экрана
    private func updateScreen(){
        for index in game.items.indices {
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError{
                UIView.animate(withDuration: 0.3) {[weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .cyan
                    self?.game.items[index].isError = false
                }
            }
        }
        
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status:StatusGame){
        switch  status {
        case .start:
            statusGame.text = "Игра началась"
            statusGame.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusGame.text = "Вы выиграли"
            statusGame.textColor = .green
            newGameButton.isHidden = false
        case .lose:
            statusGame.text = "Вы проиграли"
            statusGame.textColor = .red
            newGameButton.isHidden = false
        }
    }
}
