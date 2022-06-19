//
//
//  Created by sutk on 5/12/22.
//  Copyright © 2022 . All rights reserved.
//

import UIKit
import SnapKit

struct TokenConfig {
    static let font = UIFont.systemFont(ofSize: 14)
    static let backgroundTokenColor: UIColor = UIColor(hex: "007AFF")
    static let limitCharacter: Int64 = Int64.max
    
    static func getDefaultName() -> (mark: String, value: String) {
        return (mark: "Document, \(TokenType.MM.mark)/\(TokenType.DD.mark), \(TokenType.time.mark)",
                value: "Document, \(TokenType.MM.value)/\(TokenType.DD.value), \(TokenType.time.value)")
    }
    
    
}
public class TokenTextView: UIView {
    private(set) var tokens: [String] = []
    private(set) var format: String = ""
    static let textViewFont = TokenConfig.font
    var heightTextView: Constraint?
    
    var textView: UITextView = {
        let tv = UITextView(frame: .zero)
        tv.backgroundColor = .clear
        tv.returnKeyType = .done
        tv.font = TokenTextView.textViewFont
        return tv
    } ()
    
   public init() {
        super.init(frame: .zero)
        self.addSubview(textView)
        self.backgroundColor = .clear
        textView.delegate = self
        textView.snp.makeConstraints { $0.edges.equalToSuperview() }
       self.snp.remakeConstraints {
           heightTextView = $0.height.equalTo(200).constraint
       }
       self.setText(text: TokenConfig.getDefaultName().mark)
       DispatchQueue.main.async {
            self.checkHeightTokenView()
       }
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    func setText(text: String) {
        self.tokens = []
        self.format = text
        let arrText = text.components(separatedBy: "$")
        let allTokens = TokenType.allCases
        let font = TokenTextView.textViewFont
        
        let fullString = NSMutableAttributedString()
        arrText.forEach { str in
            if allTokens.contains(where: { $0.display == str }) {
                let img = circleToken(string: str, font: font)
                let imageString = NSAttributedString(attachment: NSTextAttachment(image: img))
                fullString.append(imageString)
                tokens.append(str)
            } else {
                fullString.append(NSAttributedString(string: str, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.baselineOffset: 6]))
            }
        }
        textView.attributedText = fullString
        textDidChange()
    }
    
    
    func circleToken(string: String, font: UIFont) -> UIImage {
        let circleColor: UIColor = TokenConfig.backgroundTokenColor
        let textColor: UIColor = .white
        let height: CGFloat = 25
        
        let width = string.width(font: font) + 20
        
        let p = NSMutableParagraphStyle()
        p.alignment = .center
        let s = NSAttributedString(string: string, attributes:
                                    [.font:font, .foregroundColor: textColor, .paragraphStyle:p/*, .backgroundColor: circleColor*/])
        let r = UIGraphicsImageRenderer(size: CGSize(width:width, height:height))
        return r.image {con in
            circleColor.setFill()
            let bezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: height), cornerRadius: 10)
            bezierPath.lineWidth = 0
            bezierPath.fill()
            s.draw(in: CGRect(x: 0, y: height / 2 - font.lineHeight / 2, width: width, height: height))
        }
    }
    
    func insertToken(token: TokenType, at index: Int) {
        //        let location
        var fullText = self.format
        var results: [(range: Range<String.Index>, nsRange: NSRange, token: TokenType)] = []
        
        // find all token in full text
        TokenType.allCases.forEach { token in
            fullText.ranges(of: token.mark).forEach { range in
                let nsRange = NSRange(range, in: fullText)
                results.append((range: range, nsRange: nsRange, token: token))
            }
        }
        
        // sort
        results = results.sorted(by: { $0.nsRange.location > $1.nsRange.location })
        
        // remove range text and calculate location agin
        results.enumerated().forEach { value in
            fullText.insert(TokenType.markCharacter, at: fullText.indexs(from: value.element.nsRange).start)
            fullText.removeSubrange(value.element.range)
            for idx in 0..<value.offset {
                let nsRange = results[idx].nsRange
                let v = (nsRange.location - value.element.nsRange.length) + 1
                results[idx].nsRange.location = max(0, min(fullText.count, v))
            }
        }
        
        // calcualtor new Range
        let arr = results.filter { $0.nsRange.location < index }
        let location = index + arr.reduce(0) { return $0 + $1.nsRange.length } - arr.count
        
        let newRange = NSRange(location: location, length: 0)
        
        let newString = (self.format as NSString).replacingCharacters(in: newRange, with: token.mark)
        self.setText(text: newString)
        
        // set cursor again
        if let newPosition = textView.position(from: textView.beginningOfDocument, offset: index + 1) {
            textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
        }
        textDidChange()
    }
    
    
    func checkHeightTokenView() {
        let maxHeight = textView.subviews.compactMap { $0.bounds.height }.max()
        heightTextView?.update(offset: maxHeight ?? 50)
        self.layoutIfNeeded()
    }
    
    func textDidChange() {
        checkHeightTokenView()
    }
}


extension TokenTextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        textDidChange()
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // check return key
        if text == "\n" {
             textView.resignFirstResponder()
             return false
         }
//        let location
        var fullText = self.format
        var results: [(range: Range<String.Index>, nsRange: NSRange, token: TokenType)] = []

        // find all token in full text
        TokenType.allCases.forEach { token in
            fullText.ranges(of: token.mark).forEach { range in
                let nsRange = NSRange(range, in: fullText)
                results.append((range: range, nsRange: nsRange, token: token))
            }
        }
        
        // sort
        results = results.sorted(by: { $0.nsRange.location > $1.nsRange.location })
        
        // remove range text and calculate location agin
        results.enumerated().forEach { value in
            fullText.insert(TokenType.markCharacter, at: fullText.indexs(from: value.element.nsRange).start)
            fullText.removeSubrange(value.element.range)
            for idx in 0..<value.offset {
                let nsRange = results[idx].nsRange
                let v = (nsRange.location - value.element.nsRange.length) + 1
                results[idx].nsRange.location = max(0, min(fullText.count, v))
            }
        }
        
        // calcualtor new Range
        let arr = results.filter { $0.nsRange.location < range.location }
        let location = range.location + arr.reduce(0) { return $0 + $1.nsRange.length } - arr.count
        
        let tempts = results.filter { $0.nsRange.location >= range.location && $0.nsRange.location < (range.location + range.length)}
        let length = range.length + tempts.reduce(0) { return $0 + $1.nsRange.length } - tempts.count
        
        let newRange = NSRange(location: location, length: length)
        
        if newRange.location >= 0, newRange.location <= self.format.count, newRange.location + newRange.length <= self.format.count {
            let newString = (self.format as NSString).replacingCharacters(in: newRange, with: text)
            
            //limi 100 character
            if newString.count > TokenConfig.limitCharacter && !text.isEmpty { return false }
            self.setText(text: newString)
            
            // set cursor again
            if let newPosition = textView.position(from: textView.beginningOfDocument, offset: range.location + (text.isEmpty ? 0 : 1)) {
                textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
            }
        }
//        print(self.text)
//        print(fullText)
//        print(results)
        textDidChange()
        return false
    }

}
