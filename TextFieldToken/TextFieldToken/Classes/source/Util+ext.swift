//
//
//  Created by sutk on 5/12/22.
//  Copyright © 2022 . All rights reserved.
//

import UIKit

extension String {
    func indexs(from range: NSRange) -> (start: String.Index, end: String.Index) {
        return (start: self.index(self.startIndex, offsetBy:  range.location + 1),
                end: self.index(self.startIndex, offsetBy:  (range.location + range.length)))
    }
    /*
    func width(font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        
        return size.width
    }
     */
}





extension String {
    func width(font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        
        return size.width
    }
}

extension Date {
    func string(formatter: String = "MMM dd, yyyy") -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = formatter
        return dateFormatterGet.string(from: self)
    }
}



public extension UIColor {
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1)
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue: UInt32 = 10066329 //color #999999 if string has wrong format
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) == 6 {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}



extension StringProtocol {
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
