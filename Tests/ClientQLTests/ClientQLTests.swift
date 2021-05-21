    import XCTest
    @testable import ClientQL
    import Combine

    final class ClientQLTests: XCTestCase {
        
        func testPayload() {
            // given
            let client = GQLClient({ _ in fatalError() }, encoder: .init(), decoder: .init())
            let request = GQLRequest<MockObject>(.query, field: "myUser", parameters: [.init(name: "car", value: "Camry")])
            
            // when
            let payload = client.buildPayload(with: request)
            
            // then
            XCTAssertEqual(payload.query, "query MyUser($car: String!) { success: myUser(car: $car) { id name createdTS } }")
        }
    }
