import XCTest
@testable import collector

final class collectorTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(collector().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
