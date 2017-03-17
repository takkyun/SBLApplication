import UIKit
import XCTest
import SBLApplication

class Tests: XCTestCase {

  func testDisplayName() {
    XCTAssertEqual(SBLApplication.displayName, "SBLApplication_Example")
  }

  func testAppVersion() {
    XCTAssertEqual(SBLApplication.appVersion, "1.0 (1)")
  }

}
