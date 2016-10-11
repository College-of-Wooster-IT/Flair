//
//  StyleParser.swift
//  FlairParser
//
//  Created by Jerry Mayers on 7/25/16.
//  Copyright © 2016 Mobelux. All rights reserved.
//

import Foundation

enum StyleParser {
    private enum Constants {
        static let stylesKey = "styles"
    }
    
    static func parse(json: JSON, namedColors: [NamedColorSet]) throws -> [NamedStyle] {
        guard let styleDict = json[Constants.stylesKey] as? JSON else { throw Parser.ParserError.missingStyleDict }
        
        var styles: [NamedStyle] = []
        for styleKey in styleDict.keys {
            if let value = styleDict[styleKey] as? JSON {
                let style = try NamedStyle(name: styleKey, styleValues: value, colors: namedColors)
                styles.append(style)
            }
        }
        
        return styles
    }
}