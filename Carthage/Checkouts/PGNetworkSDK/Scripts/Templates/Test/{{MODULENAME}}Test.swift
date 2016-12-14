import XCTest
@testable import PGNetworkSDK

class {{MODULENAME}}Test: XCTestCase {
    var sut: {{MODULENAME}}Request!
    
    override func setUp() {
        super.setUp()
        PGNetworkSDK.sharedInstance.baseUrl = "https://api.propertyguru.com"
        PGNetworkSDK.sharedInstance.country = "sg"
        PGNetworkSDK.sharedInstance.locale = "en"
        PGNetworkSDK.sharedInstance.networkAccessToken = "token"
        sut = {{MODULENAME}}Request()
        sut.baseUrl = "https://api.propertyguru.com.sg"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: API Path
    func test_ApiPath() {
        let expected = "https://api.propertyguru.com/v1/xxxxx/{{MODULENAME}}" // TODO : Replace with correct api path
        let actual = sut.fullApiPath!
        XCTAssertEqual(actual, expected)
    }
    
    func test_Parameters() {
        let expected: NSDictionary = ["access_token": "token"]
        let actual = NSDictionary(dictionary: sut.requestParameters!)
        XCTAssertEqual(actual, expected)
    }
    
    func test_Network_success() {
        let expectation = self.expectation(description: "Network_Success")
        // TODO :Replace the sample json key path with the correct one
        sut.networkManager = StubPGNetworkManager(expectedJson: SampleJson("{{MODULENAME}}.get"), expectedError: nil)
        sut.send(success: { response in
            guard let output = response as? {{MODULENAME}}Response else {
                XCTAssertFalse(true)
                return
            }
            // TODO :Do the detail test for output's parameters
            expectation.fulfill()
            }, failure: { error in
        })
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
}
