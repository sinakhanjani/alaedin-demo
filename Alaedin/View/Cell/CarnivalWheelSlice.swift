//
//  CarnivalWheelSlice.swift
//  TTFortuneWheelSample
//
//  Created by Efraim Budusan on 11/1/17.
//  Copyright © 2017 Tapptitude. All rights reserved.
//

import Foundation
import TTFortuneWheel

public class CarnivalWheelSlice: FortuneWheelSliceProtocol {
    
    public enum Style {
        case brickRed
        case sandYellow
        case babyBlue
        case deepBlue
    }
    
    public var title: String
    public var degree: CGFloat = 0.0
    
    public var backgroundColor: UIColor? {
        switch style {
        case .brickRed: return TTUtils.uiColor(from:0x57DE2C)
        case .sandYellow: return TTUtils.uiColor(from:0x22A7E0)
        case .babyBlue: return TTUtils.uiColor(from:0xDA2663)
        case .deepBlue: return TTUtils.uiColor(from:0xF7AA35)
        }
    }
    
    public var fontColor: UIColor {
        return UIColor.white
    }
    
    public var offsetFromExterior:CGFloat {
        return 30.0
    }
    
    public var font: UIFont {
        switch style {
        case .brickRed: return UIFont(name: MORVARID_FONT, size: 14.0)!
        case .sandYellow: return UIFont(name: MORVARID_FONT, size: 14.0)!
        case .babyBlue: return UIFont(name: MORVARID_FONT, size: 14.0)!
        case .deepBlue: return UIFont(name: MORVARID_FONT, size: 14.0)!
        }
    }
    
    public var stroke: StrokeInfo? {
        return StrokeInfo(color: UIColor.white, width: 1.0)
    }
    
    public var style:Style = .brickRed
    
    public init(title:String) {
        self.title = title
    }
    
    public convenience init(title:String, degree:CGFloat) {
        self.init(title:title)
        self.degree = degree
    }
    
}