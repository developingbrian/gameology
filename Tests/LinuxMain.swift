import XCTest

import collectorTests

var tests = [XCTestCaseEntry]()
tests += collectorTests.allTests()
XCTMain(tests)
