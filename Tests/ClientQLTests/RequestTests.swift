    import XCTest
    @testable import ClientQL
    
    struct MockObject : GQLObject {
        let id : UUID
        let name : String
        let createdTS : TimeInterval
        
        init(from decoder: GQLDecoder<Keys>) throws {
            self.id = try decoder.from(.id)
            self.name = try decoder.from(.name)
            self.createdTS = try decoder.from(.createdTS)
        }
        
        enum Keys : String, CodingKey {
            case id, name, createdTS
        }
    }

    final class RequestTests: XCTestCase {
        
        func testTitle() {
            // given
            let request = GQLRequest<UUID>(.query, field: "myUser")
            
            // then
            XCTAssertEqual(request.title, "MyUser")
        }
        
        func testInlineParameters(){
            // given
            let request = GQLRequest<UUID>(.query, field: "myUser", parameters: ["car": "Camry"])
            let params = request.inlineParamaters
            
            // then
            XCTAssertEqual(params.title, "($car: String!)")
            XCTAssertEqual(params.field, "(car: $car)")
        }
        
        func testVariables(){
            // given
            let request = GQLRequest<UUID>(.query, field: "myUser", parameters: ["car": "Camry"])
            
            // then
            XCTAssertEqual(request.variables?["car"]?.value as? String, "Camry")
        }
        
        func testPrimitiveQuery(){
            // given
            let request = GQLRequest<UUID>(.query, field: "myUser", parameters: ["car": "Camry"])
            
            // then
            XCTAssertEqual(request.query, "query MyUser($car: String!) { success: myUser(car: $car) }")
        }
        
        func testObjectQuery(){
            // given
            let request = GQLRequest<MockObject>(.query, field: "myUser", parameters: ["car": "Camry"])
            
            // then
            XCTAssertEqual(request.query, "query MyUser($car: String!) { success: myUser(car: $car) { id name createdTS } }")
        }
    }
