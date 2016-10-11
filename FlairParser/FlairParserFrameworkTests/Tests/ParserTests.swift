//
//  ParserTests.swift
//  FlairParser
//
//  Created by Jerry Mayers on 7/25/16.
//  Copyright © 2016 Mobelux. All rights reserved.
//

import XCTest
import Flair
@testable import FlairParserFramework

class ParserTests: XCTestCase {

    func testValidColors() {
        let normal = "rgba(0.0, 1.0, 0.5, 1.0)"
        let highlighted = "rgba(1.0, 0.0, 0.0, 0.5)"
        let selected = "rgba(0.25, 0.5, 0.75, 1.0)"
        let disabled = "rgba(1.0, 1.0, 1, 1)"
        
        let colorValues = ["normal" : normal, "highlighted" : highlighted, "selected" : selected, "disabled" : disabled]
        let colorNames = ["coolColor", "strangeColor"]
        let colors = [colorNames[0] : colorValues, colorNames[1] : colorValues]
        let json: JSON = ["colors" : colors, "styles" : [:]]
        
        let parser = Parser(json: json)
        
        do {
            let (namedColors, styles, jsonHash) = try parser.parse()
            XCTAssert(namedColors.count == colors.count, "Incorrect # of colors")
            XCTAssert(styles.count == 0, "Shouldn't have any styles")
            
            for namedColorSet in namedColors {
                XCTAssert(colorNames.contains(namedColorSet.name), "Expected name doesn't match")
            }
            
            XCTAssert(jsonHash.characters.count > 0, "No JSON Hash")
        } catch let error as Parser.ParserError {
            XCTAssert(false, "Failed with error \(error.legacyError)")
        } catch {
            XCTAssert(false, "Unknown error")
        }
    }
    
    func testNoColorsOrStyles() {
        let json: JSON = ["colors" : [:], "styles" : [:]]
        
        let parser = Parser(json: json)
        
        do {
            let _ = try parser.parse()
            XCTAssert(false, "We should have thrown an error")
        } catch Parser.ParserError.noColorsOrStyles {
            // Expected case
        } catch let error as Parser.ParserError {
            XCTAssert(false, "Failed with error \(error.legacyError)")
        } catch {
            XCTAssert(false, "Unknown error")
        }
    }
    
    func testMissingStyles() {
        let json: JSON = ["colors" : [:]]
        
        let parser = Parser(json: json)
        
        do {
            let _ = try parser.parse()
            XCTAssert(false, "We should have thrown an error")
        } catch Parser.ParserError.missingStyleDict {
            // Expected case
        } catch let error as Parser.ParserError {
            XCTAssert(false, "Failed with error \(error.legacyError)")
        } catch {
            XCTAssert(false, "Unknown error")
        }
    }
    
    func testMissingColors() {
        let json: JSON = ["styles" : [:]]
        
        let parser = Parser(json: json)
        
        do {
            let _ = try parser.parse()
            XCTAssert(false, "We should have thrown an error")
        } catch Parser.ParserError.missingColorDict {
            // Expected case
        } catch let error as Parser.ParserError {
            XCTAssert(false, "Failed with error \(error.legacyError)")
        } catch {
            XCTAssert(false, "Unknown error")
        }
    }
    
    func testValidColorsAndStyles() {
        let normal = "rgba(0.0, 1.0, 0.5, 1.0)"
        let highlighted = "rgba(1.0, 0.0, 0.0, 0.5)"
        let selected = "rgba(0.25, 0.5, 0.75, 1.0)"
        let disabled = "rgba(1.0, 1.0, 1, 1)"
        
        let colorValues = ["normal" : normal, "highlighted" : highlighted, "selected" : selected, "disabled" : disabled]
        let colorNames = ["coolColor", "strangeColor"]
        let colors: JSON = [colorNames[0] : colorValues, colorNames[1] : colorValues]
        
        let titleFontValue: JSON = ["size" : 25 as NSNumber, "fontName" : "Arial-Black", "sizeType" : "static"]
        let titleStyleValues: JSON = ["font" : titleFontValue, "lineSpacing" : 34 as NSNumber, "kerning" : 3 as NSNumber, "textColor" : colorNames[0]]
        
        let bodyFontValue: JSON = ["size" : 15 as NSNumber, "fontName" : "Arial-Black", "sizeType" : "dynamic"]
        let bodyStyleValues: JSON = ["font" : bodyFontValue, "lineSpacing" : 14 as NSNumber, "kerning" : 1 as NSNumber, "textColor" : colorNames[1]]
        
        let styleNames = ["title", "body"]
        let namedStyles: JSON = [styleNames[0] : titleStyleValues, styleNames[1] : bodyStyleValues]
        let json: JSON = ["colors" : colors, "styles" : namedStyles]
        
        let parser = Parser(json: json)
        
        do {
            let (namedColors, styles, _) = try parser.parse()
            XCTAssert(namedColors.count == colors.count, "Incorrect # of colors")
            XCTAssert(styles.count == namedStyles.count, "Incorrect # of styles")
            
            for namedColorSet in namedColors {
                XCTAssert(colorNames.contains(namedColorSet.name), "Expected name doesn't match")
            }
            
            for namedStyle in styles {
                XCTAssert(styleNames.contains(namedStyle.name), "Expected name doesn't match")
            }
        } catch let error as Parser.ParserError {
            XCTAssert(false, "Failed with error \(error.legacyError)")
        } catch {
            XCTAssert(false, "Unknown error")
        }
    }
    
    func testInitFromURL() {
        let json = Bundle(for: ParserTests.self).url(forResource: "validColorAndStyle", withExtension: "json")!
        
        do {
            let parser = try Parser(json: json)
            let (colors, styles, _) = try parser.parse()
            XCTAssert(colors.count == 2, "Invalid # of colors")
            XCTAssert(styles.count == 2, "Invalid # of styles")
            
        } catch let error as Parser.ParserError {
            XCTAssert(false, "Failed with error \(error.legacyError)")
        } catch {
            XCTAssert(false, "Unknown error")
        }
    }
    
    func testInitFromURLSyntaxError() {
        let json = Bundle(for: ParserTests.self).url(forResource: "syntaxErrorColorAndStyle", withExtension: "json")!
        
        do {
            let _ = try Parser(json: json)
            XCTAssert(false, "We should have thrown an error")
        } catch Parser.ParserError.unreadableJSONSyntax {
            // Expected case
        } catch let error as Parser.ParserError {
            XCTAssert(false, "Failed with error \(error.legacyError)")
        } catch {
            XCTAssert(false, "Unknown error")
        }
    }
    
    func testInitFromInvalidURLError() {
        let json = URL(fileURLWithPath: "")
        
        do {
            let _ = try Parser(json: json)
            XCTAssert(false, "We should have thrown an error")
        } catch Parser.ParserError.cantOpenJSONFile {
            // Expected case
        } catch let error as Parser.ParserError {
            XCTAssert(false, "Failed with error \(error.legacyError)")
        } catch {
            XCTAssert(false, "Unknown error")
        }
    }
}