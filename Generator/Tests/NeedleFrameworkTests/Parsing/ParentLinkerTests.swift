//
//  Copyright (c) 2018. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import XCTest
@testable import NeedleFramework

class ParentLinkerTests: AbstractParserTests {

    static var allTests = [
        ("test_process_withComponents_verifyLinkages", test_process_withComponents_verifyLinkages),
    ]

    func test_process_withComponents_verifyLinkages() {
        let parentComponent = ASTComponent(name: "ParentComp", dependencyProtocolName: "Doesn't matter", properties: [], expressionCallTypeNames: ["ChildComp", "someOtherStuff"])
        let childComp = ASTComponent(name: "ChildComp", dependencyProtocolName: "Still doesn't matter", properties: [], expressionCallTypeNames: [])

        let linker = ParentLinker(components: [parentComponent, childComp])
        try! linker.process()

        XCTAssertEqual(childComp.parents.count, 1)
        XCTAssertTrue(childComp.parents[0] === parentComponent)
    }
}
