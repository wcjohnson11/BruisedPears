//
//  Style.swift
//  Tippo
//
//  Created by William Johnson on 12/27/15.
//  Copyright (c) 2015 William Johnson. All rights reserved.
//

import UIKit

// Extend UIColor with hex values
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

let leaf = UIColor(hexString: "#3CC76A")
let charcoal = UIColor(hexString: "#54585E")
let slate = UIColor(hexString: "#707479")
let sand = UIColor(hexString: "#FCFAF7")
let white = UIColor(hexString: "#FFFFFF")
let cognac = UIColor(hexString: "#B34622")
let fire = UIColor(hexString: "#EB5C2D")
let tussock = UIColor(hexString: "#C79D3C")
let mango = UIColor(hexString: "#FAC54B")
let pine = UIColor(hexString: "#089972")
let stone = UIColor(hexString: "#CCBEAD")
let fog = UIColor(hexString: "#B7BDC4")
let abbey = UIColor(hexString: "#42454A")
let purple = UIColor(hexString: "#A357B0")
let navy = UIColor(hexString: "#4D4FD2")
let emerald = UIColor(hexString: "#24B94F")

struct Style{
    // MARK: Blue Color Schemes
    
    static var billFieldFont = UIFont(name: "Helvetica-Bold", size: 70)
    static var viewBackgroundColor = sand
    static var billBackgroundColor = white
    static var tipTextColor = leaf
    static var totalTextColor = charcoal
    static var totalBackgroundColor = white
    static var friendsViewBackgroundColor = slate
    static var billTextColor = charcoal
    static func themeLight() {
        viewBackgroundColor = sand
        billBackgroundColor = white
        tipTextColor = leaf
        totalTextColor = charcoal
        totalBackgroundColor = white
        friendsViewBackgroundColor = slate
        billTextColor = charcoal
    }
    static func themeDark(){
        viewBackgroundColor = charcoal
        billBackgroundColor = slate
        totalTextColor = leaf
        tipTextColor = mango
        friendsViewBackgroundColor = leaf
        billTextColor = white
    }
}