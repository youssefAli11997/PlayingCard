//
//  PlayingCardview.swift
//  PlayingCard
//
//  Created by Owner on 7/4/19.
//  Copyright © 2019 Owner. All rights reserved.
//

import UIKit

//@IBDesignable
class PlayingCardView: UIView {

    
    @IBOutlet var playingCardView: UIView!
    
    var rank: Int = 5 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var suit: String = "♥️" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var faceCardScale = SizeRatio.faceCardImageSizeToBoundsSize  { didSet { setNeedsDisplay() } }
    
    private var cornerString: NSAttributedString {
        return centeredAttributedString(rankString + "\n" + suit, fontSize: cornerFontSize)
    }
    
    private lazy var upperLeftCornerLabel = createCornerLabel()
    private lazy var lowerRightCornerLabel = createCornerLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        print("\(#function)")
        Bundle.main.loadNibNamed("PlayingCardView", owner: self, options: nil)
        addSubview(playingCardView)
        playingCardView.frame = self.bounds
        playingCardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func createCornerLabel() -> UILabel {
        print("\(#function)")
        let label = UILabel()
        label.numberOfLines = 0
        playingCardView.addSubview(label)
        return label
    }
    
    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle, .font: font])
    }
    
    func configureCornerLabel(_ label: UILabel) {
        label.attributedText = cornerString
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }
    
    @objc func adjustFaceCardScale(byHandlingGestureRecoginzedBy recognizer: UIPinchGestureRecognizer) {
        print("\(#function)")
        switch recognizer.state {
        case .changed, .ended:
            faceCardScale *= recognizer.scale
            recognizer.scale = 1.0
        default: break
        }
    }
    
    override func draw(_ rect: CGRect) {
        print("\(#function)")
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        if !isFaceUp {
            if let cardbackImage = UIImage(named: "cardback") {
                print("Found the image!!!")
                print(bounds)
                cardbackImage.draw(in: bounds/*.zoom(by: faceCardScale)*/)
            }
            else{
                print("Here!!!")
            }
        }
    }
    
    override func layoutSubviews() {
        print("\(#function)")
        super.layoutSubviews()
        
        configureCornerLabel(upperLeftCornerLabel)
        configureCornerLabel(lowerRightCornerLabel)
        
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
        lowerRightCornerLabel.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi)
    }
    
    // to handle changes such as system font size
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        playingCardView.setNeedsDisplay()
        playingCardView.setNeedsLayout()
    }
    
    override func awakeFromNib() {
        print("\(#function)")
        super.awakeFromNib()
    }
}
