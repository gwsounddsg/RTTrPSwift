// =================================================================
// Created by:  GW Rodriguez
// Date:        12/22/19
// License:     2019 RTTrP-Swift is released under the MIT License.
// =================================================================

import XCTest





// Found here: https://www.swiftbysundell.com/articles/testing-error-code-paths-in-swift/
extension XCTestCase {
    
    func assert<T, E: Error & Equatable>(
        _ expression: @autoclosure () throws -> T,
        throws error: E,
        in file: StaticString = #file,
        line: UInt = #line
    ) {
        var thrownError: Error?

        XCTAssertThrowsError(try expression(), file: file, line: line) {
            thrownError = $0
        }

        XCTAssertTrue(
            thrownError is E,
            "Unexpected error type: \(type(of: thrownError))",
            file: file, line: line
        )

        XCTAssertEqual(
            thrownError as? E, error,
            file: file, line: line
        )
    }
}
