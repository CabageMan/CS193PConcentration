//
//  ViewController.swift
//  Concentration
//
//  Created by ViktorsMacbook on 30.11.18.
//  Copyright © 2018 Viktor Bednyi Inc. All rights reserved.
//

import UIKit

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

class ViewController: UIViewController {
    
    // MARK: Variable Declaration
    
    // Use lazy for correct initialization
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    // Create read only computed variable numberOfPairsOfCards
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private var emojiChoices = Array<String>()
    
    private var emoji = [Card: String]()
    
    private var buttonsColor = UIColor()
    
    private var themesChoices = [
        ["emojiChoices": ["🎃", "👻", "☠️", "💩", "💀", "👁", "😈", "👺", "😱"],
         "backGroundColor": #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
         "cardsBackSideColor": #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)],
        ["emojiChoices": ["🐱", "🐶", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨"],
         "backGroundColor": #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),
         "cardsBackSideColor": #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)],
        ["emojiChoices": ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓"],
         "backGroundColor": #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),
         "cardsBackSideColor": #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)],
        ["emojiChoices": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓"],
         "backGroundColor": #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1),
         "cardsBackSideColor": #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)],
        ["emojiChoices": ["😃", "😆", "😂", "☺️", "😇", "😉", "😜", "🤗", "😎"],
         "backGroundColor": #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
         "cardsBackSideColor": #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)],
        ["emojiChoices": ["🙏🏻", "🤝", "👍", "👍", "👎", "👊", "✊", "🤘", "✌️"],
         "backGroundColor": #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
         "cardsBackSideColor": #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]
    ]

    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameStart()
    }
    
    // MARK: Handle Touch Card Behavior
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumberIndex = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumberIndex)
            updateViewFromModel()
        } else {
            print("Choosen card not found")
        }
    }
    
    // Update view by model data changing
    private func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            /*
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : buttonsColor
            }
            */
            if card.isMatched {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                button.isEnabled = false
                button.setTitle("", for: UIControlState.normal)
            } else if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = buttonsColor
            }
        }
    }
    
    // Get random emoji for the cards array
    private func emoji(for card: Card) -> String {
        
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.arc4random
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        // return placeholder if optional value in dictionary not set
        return emoji[card] ?? "?"
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        gameStart()
        updateViewFromModel()
    }
    
    private func gameStart() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        setTheme()
    }
    
    private func setTheme() {
        //print("We Are in set theme method")
        let randomIndexOfTheme = themesChoices.count.arc4random
        let theme = themesChoices[randomIndexOfTheme]
        if theme["emojiChoices"] != nil, theme["backGroundColor"] != nil, theme["cardsBackSideColor"] != nil {
            emojiChoices = theme["emojiChoices"] as! [String]
            buttonsColor = theme["cardsBackSideColor"] as! UIColor
            
            // Set background, buttons and labels color
            self.view.backgroundColor = theme["backGroundColor"] as? UIColor
            for button in cardButtons {
                button.backgroundColor = buttonsColor
                button.isEnabled = true
            }
            flipCountLabel.textColor = buttonsColor
            scoreLabel.textColor = buttonsColor
            newGameButton.setTitleColor(buttonsColor, for: UIControlState.normal)
        } else {
            emojiChoices = Array(repeating: "?", count: cardButtons.count)
        }
    }
    
}

