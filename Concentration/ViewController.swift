//
//  ViewController.swift
//  Concentration
//
//  Created by ViktorsMacbook on 30.11.18.
//  Copyright © 2018 Viktor Bednyi Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Variable Declaration
    
    // Use lazy for correct initialization
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    /*
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    */
    
    var emojiChoices = Array<String>()
    
    var emoji = [Int: String]()
    
    var themesChoices = [
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
         "cardsBackSideColor": #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    ]

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Color before gamestart \(self.view.backgroundColor ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))")

        gameStart()
        print("Color after game start \(self.view.backgroundColor ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))")

    }
    
    // MARK: Handle Touch Card Behavior
    
    @IBAction func touchCard(_ sender: UIButton) {
        //flipCount += 1
        print("Color in touchcard \(self.view.backgroundColor ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))")
        if let cardNumberIndex = cardButtons.index(of: sender) {
            //flipCard(withEmoji: emojiChoices[cardNumberIndex], on: sender)
            game.chooseCard(at: cardNumberIndex)
            updateViewFromModel()
        } else {
            print("Choosen card not found")
        }
    }
    
    // Update view by model data changing
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    // Get random emoji for the cards array
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        // return placeholder if optional value in dictionary not set
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        gameStart()
        updateViewFromModel()
    }
    
    func gameStart() {
        //flipCount = 0
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        //emojiChoices = ["🎃", "👻", "☠️", "💩", "💀", "👁", "😈", "👺", "😱"]
        setTheme()
    }
    
    func setTheme() {
        print("We Are in set theme method")
        let randomIndexOfTheme = Int(arc4random_uniform(UInt32(themesChoices.count)))
        let theme = themesChoices[randomIndexOfTheme]
        if theme["emojiChoices"] != nil, theme["backGroundColor"] != nil, theme["cardsBackSideColor"] != nil {
            emojiChoices = theme["emojiChoices"] as! [String]
            self.view.backgroundColor = theme["backGroundColor"] as? UIColor
            for button in cardButtons {
                button.backgroundColor = theme["cardsBackSideColor"] as? UIColor
            }
        } else {
            emojiChoices = Array(repeating: "?", count: cardButtons.count)
        }
    }
    
}

