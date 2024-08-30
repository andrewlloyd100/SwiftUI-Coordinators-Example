import XCTest
@testable import SwiftUICoordinator

final class SwiftUICoordinatorTests: XCTestCase {
    
    func testCoordinatorNavigation() throws {
        
        let coordinator = CoordinatorModel()
        
        //path is empty, we are at the root (A)
        XCTAssertTrue(coordinator.path.isEmpty)
        
        let rootVm = coordinator.rootViewModel
        //present B from A ViewModel
        rootVm.tapB()
        
        //assert B is shown
        guard let route = coordinator.path.last else {
            XCTFail("should have one path element")
            return
        }
        if case .bScreen(let vm) = route {
            //passed, B is shown
            
            //present C from B ViewModel
            vm.onTapC()
        } else {
            XCTFail("path element not expected, should be B")
        }
        
        //assert C is shown
        guard let route = coordinator.path.last else {
            XCTFail("should have one path element")
            return
        }
        if case .cScreen = route {
            //passed
            //assert our path now has two values, one B & one C screen
            XCTAssertEqual(coordinator.path.count, 2)
        } else {
            XCTFail("path element not expected, should be C")
        }
        
        //reset path back to route
        coordinator.path = []
        //present C from A ViewModel
        rootVm.tapC()
        
        //assert C is shown
        guard let route = coordinator.path.last else {
            XCTFail("should have one path element")
            return
        }
        if case .cScreen = route {
            //passed
            //assert our path now has one value, one C screen, as we went straight from root to C
            XCTAssertEqual(coordinator.path.count, 1)
        } else {
            XCTFail("path element not expected, should be C")
        }
    }

}
