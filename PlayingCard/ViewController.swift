//
//  ViewController.swift
//  PlayingCard
//
//  Created by Owner on 7/4/19.
//  Copyright © 2019 Owner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = PlayingCardDeck()
    
    
    /*@IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecoginzedBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }*/
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecoginzedBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended: playingCardView.isFaceUp = !playingCardView.isFaceUp
        default: break
        }
    }
    
    @objc func nextCard() {
        print("\(#function)")
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order!
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

