//
//  OperatorTests.swift
//  Cartography
//
//  Created by Robert Böhnke on 18/06/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

import Cartography
import XCTest

class OperatorTests: XCTestCase {
    var superview: View!
    var view: View!

    override func setUp() {
        superview = View(frame: CGRectMake(0, 0, 200, 200))

        view = View(frame: CGRectZero)
        superview.addSubview(view)
    }

    func testAddition() {
        var constraint: NSLayoutConstraint!

        layout(view) { view in
            constraint = view.width == view.superview!.width + 100
        }

        XCTAssertEqual(constraint.constant, CGFloat(100), "It should set the constant")
    }

    func testSubtraction() {
        var constraint: NSLayoutConstraint!

        layout(view) { view in
            constraint = view.width == view.superview!.width - 100
        }

        XCTAssertEqual(constraint.constant, CGFloat(-100), "It should set the constant")
    }

    func testMultiplication() {
        var constraint: NSLayoutConstraint!

        layout(view) { view in
            constraint = view.width == (view.superview!.width + 100) * 2 + 5
        }

        XCTAssertEqual(constraint.multiplier, CGFloat(2), "It should set the constant")
        XCTAssertEqual(constraint.constant, CGFloat(205), "It should multiply the constant")
    }

    func testDivision() {
        var constraint: NSLayoutConstraint!

        layout(view) { view in
            constraint = view.width == (view.superview!.width + 100) / 2 + 5
        }

        XCTAssertEqual(constraint.multiplier, CGFloat(0.5), "It should set the constant")
        XCTAssertEqual(constraint.constant, CGFloat(55), "It should divide the constant")
    }

    func testDivision2() {
        var constraint: NSLayoutConstraint!

        layout(view) { view in
            constraint = view.width == view.superview!.width / 2
        }

        XCTAssertEqual(constraint.multiplier, CGFloat(0.5), "It should set the constant")
    }

    func testPriority() {
        var constraint: NSLayoutConstraint!

        layout(view) { view in
            constraint = (view.width == 200 ~ 100)
        }

        XCTAssertEqual(constraint.priority, UILayoutPriority(100), "It should set the priority")
    }

    func testPriorities() {
        var constraints: [NSLayoutConstraint]!

        layout(view) { view in
            constraints = (view.size <= view.superview!.size ~ 100)
        }

        XCTAssertEqual(constraints[0].priority, UILayoutPriority(100), "It should set the priority")
        XCTAssertEqual(constraints[1].priority, UILayoutPriority(100), "It should set the priority")
    }
}
