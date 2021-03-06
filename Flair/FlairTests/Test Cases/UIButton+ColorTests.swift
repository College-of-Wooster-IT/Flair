//
//  UIButton+BackgroundColorTests.swift
//  Flair
//
//  MIT License
//
//  Copyright (c) 2017 Mobelux
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import XCTest
import Flair

class UIButton_ColorTests: XCTestCase {
    
    func testNormalAndHighlightState() {
        let normalColor = UIColor.red
        let highlightedColor = UIColor.green
        
        let button = UIButton(type: .custom)
        button.setBackgroundColor(color: normalColor, for: .normal)
        button.setBackgroundColor(color: highlightedColor, for: .highlighted)
        
        let expectedNormalColor = button.backgroundColor(for: .normal)
        XCTAssertNotNil(expectedNormalColor, "Color was nil, but shouldn't be")
        guard let foundNormalColor = expectedNormalColor else { return }
        XCTAssert(foundNormalColor === normalColor, "Color we set is not the color we got")
        
        let expectedHighlightedColor = button.backgroundColor(for: .highlighted)
        XCTAssertNotNil(expectedHighlightedColor, "Highlight color was nil but shouldn't be")
        guard let foundHighlightColor = expectedHighlightedColor else { return }
        XCTAssert(foundHighlightColor === highlightedColor, "Color we set is no the color we got")
        
        let expectedNormalImage = button.backgroundImage(for: .normal)
        XCTAssertNotNil(expectedNormalImage, "Button's background image didn't get set")
        guard let normalImage = expectedNormalImage else { return }
        for pixel in try! normalImage.pixels() {
            XCTAssert(pixel == normalColor, "The image's pixel was NOT the expected color")
        }
        
        let expectedHighlightedImage = button.backgroundImage(for: .highlighted)
        XCTAssertNotNil(expectedHighlightedImage, "Button's background image didn't get set")
        guard let highlightedImage = expectedHighlightedImage else { return }
        for pixel in try! highlightedImage.pixels() {
            XCTAssert(pixel == highlightedColor, "The image's pixel was NOT the expected color")
        }
    }
    
    func testSelectedState() {
        let color = UIColor.red
        let state = UIControlState.selected
        
        let button = UIButton(type: .custom)
        button.setBackgroundColor(color: color, for: state)
        
        let expectedColor = button.backgroundColor(for: state)
        XCTAssertNotNil(expectedColor, "Color was nil, but shouldn't be")
        guard let foundColor = expectedColor else { return }
        XCTAssert(foundColor === color, "Color we set is not the color we got")
        
        let expectedImage = button.backgroundImage(for: state)
        XCTAssertNotNil(expectedImage, "Button's background image didn't get set")
        guard let foundImage = expectedImage else { return }
        for pixel in try! foundImage.pixels() {
            XCTAssert(pixel == color, "The image's pixel was NOT the expected color")
        }
    }
    
    func testDisabledState() {
        let color = UIColor.red
        let state = UIControlState.disabled
        
        let button = UIButton(type: .custom)
        button.setBackgroundColor(color: color, for: state)
        
        let expectedColor = button.backgroundColor(for: state)
        XCTAssertNotNil(expectedColor, "Color was nil, but shouldn't be")
        guard let foundColor = expectedColor else { return }
        XCTAssert(foundColor === color, "Color we set is not the color we got")
        
        let expectedImage = button.backgroundImage(for: state)
        XCTAssertNotNil(expectedImage, "Button's background image didn't get set")
        guard let foundImage = expectedImage else { return }
        for pixel in try! foundImage.pixels() {
            XCTAssert(pixel == color, "The image's pixel was NOT the expected color")
        }
    }
    
    func testFocusedState() {
        let color = UIColor.red
        let state = UIControlState.focused
        
        let button = UIButton(type: .custom)
        button.setBackgroundColor(color: color, for: state)
        
        let expectedColor = button.backgroundColor(for: state)
        XCTAssertNotNil(expectedColor, "Color was nil, but shouldn't be")
        guard let foundColor = expectedColor else { return }
        XCTAssert(foundColor === color, "Color we set is not the color we got")
        
        let expectedImage = button.backgroundImage(for: state)
        XCTAssertNotNil(expectedImage, "Button's background image didn't get set")
        guard let foundImage = expectedImage else { return }
        for pixel in try! foundImage.pixels() {
            XCTAssert(pixel == color, "The image's pixel was NOT the expected color")
        }
    }
    
    func testApplicationState() {
        let color = UIColor.red
        let state = UIControlState.application
        
        let button = UIButton(type: .custom)
        button.setBackgroundColor(color: color, for: state)
        
        let expectedColor = button.backgroundColor(for: state)
        XCTAssertNotNil(expectedColor, "Color was nil, but shouldn't be")
        guard let foundColor = expectedColor else { return }
        XCTAssert(foundColor === color, "Color we set is not the color we got")
        
        let expectedImage = button.backgroundImage(for: state)
        XCTAssertNotNil(expectedImage, "Button's background image didn't get set")
        guard let foundImage = expectedImage else { return }
        for pixel in try! foundImage.pixels() {
            XCTAssert(pixel == color, "The image's pixel was NOT the expected color")
        }
    }
    
    func testReservedState() {
        let color = UIColor.red
        let state = UIControlState.reserved
        
        let button = UIButton(type: .custom)
        button.setBackgroundColor(color: color, for: state)
        
        let expectedColor = button.backgroundColor(for: state)
        XCTAssertNotNil(expectedColor, "Color was nil, but shouldn't be")
        guard let foundColor = expectedColor else { return }
        XCTAssert(foundColor === color, "Color we set is not the color we got")
        
        let expectedImage = button.backgroundImage(for: state)
        XCTAssertNotNil(expectedImage, "Button's background image didn't get set")
        guard let foundImage = expectedImage else { return }
        for pixel in try! foundImage.pixels() {
            XCTAssert(pixel == color, "The image's pixel was NOT the expected color")
        }
    }
    
    func testInvalidState() {
        let color = UIColor.red
        let state: UIControlState = UIControlState(rawValue: 24)
        
        let button = UIButton(type: .custom)
        button.setBackgroundColor(color: color, for: state)
        let foundColor = button.backgroundColor(for: state)
        XCTAssertNil(foundColor, "We got a valid color, for an invalid state")
    }

    func testBackgroundColorSet() {
        let red = Color(color: UIColor.red)!
        let green = Color(color: UIColor.green)!
        let blue = Color(color: UIColor.blue)!
        let redFaded = Color(color: UIColor.red.withAlphaComponent(0.25))!

        let colorSet = ColorSet(normalColor: red, highlightedColor: green, selectedColor: blue, disabledColor: redFaded)
        let button = UIButton(type: .custom)
        button.setBackground(colorSet: colorSet)
        XCTAssert(button.backgroundColorSet() == colorSet, "Color set doesn't match")
        XCTAssert(button.backgroundColor(for: .normal) == red.color, "Normal color doesn't match")
        XCTAssert(button.backgroundColor(for: .highlighted) == green.color, "Highlighted color doesn't match")
        XCTAssert(button.backgroundColor(for: .selected) == blue.color, "Selected color doesn't match")
        XCTAssert(button.backgroundColor(for: .disabled) == redFaded.color, "Disabled color doesn't match")
    }

    func testTitleColorSet() {
        let red = Color(color: UIColor.red)!
        let green = Color(color: UIColor.green)!
        let blue = Color(color: UIColor.blue)!
        let redFaded = Color(color: UIColor.red.withAlphaComponent(0.25))!

        let colorSet = ColorSet(normalColor: red, highlightedColor: green, selectedColor: blue, disabledColor: redFaded)
        let button = UIButton(type: .custom)
        button.setTitle(colorSet: colorSet)
        XCTAssert(button.titleColorSet() == colorSet, "Color set doesn't match")
        XCTAssert(button.titleColor(for: .normal) == red.color, "Normal color doesn't match")
        XCTAssert(button.titleColor(for: .highlighted) == green.color, "Highlighted color doesn't match")
        XCTAssert(button.titleColor(for: .selected) == blue.color, "Selected color doesn't match")
        XCTAssert(button.titleColor(for: .disabled) == redFaded.color, "Disabled color doesn't match")
    }
}
