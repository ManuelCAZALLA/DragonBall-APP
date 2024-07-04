//
//  ConecticityModelTest.swift
//  DragonBall-APPTests
//
//  Created by Manuel Cazalla Colmenero on 30/9/23.
//

import XCTest
@testable import DragonBall_APP

final class ConecivityModelTest: XCTestCase {
    private var sut: ConnectivityModel!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        sut = ConnectivityModel(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testLogin() {
        let expectedToken = "Some Token"
        let someUser = "SomeUser"
        let somePassword = "SomePassword"
        
        MockURLProtocol.requestHandler = { request in
            let loginString = String(format: "%@:%@", someUser,somePassword)
            let loginData = loginString.data(using: .utf8)!
            let base64LoginString = loginData.base64EncodedString()
            
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"),
                           "Basic \(base64LoginString)"
            )
            
            let data = try XCTUnwrap(expectedToken.data(using: .utf8))
            let response = try XCTUnwrap(
                HTTPURLResponse(
                    url: URL(string: "https://dragonball.keepcoding.education")!,
                    statusCode: 200,
                    httpVersion: nil,
                    headerFields: ["Content-Type": "application/json"])
            )
            return (response, data)
        }
        
        let expectation = expectation(description: "Login succes")
        
        sut.login(
            user: someUser,
            password: somePassword
        ) {  result in
            guard case let .success(token) = result else {
                XCTFail("Expected succes but received \(result)")
                return
            }
            XCTAssertEqual(token, expectedToken)
            expectation.fulfill()
        }
        wait(for: [expectation])
    }
    
    func testGetHeroes ()  {
        let someHeroes: [Heroe] = [ Heroe(
            id: "1",
            name: "Goku",
            description: "El Prota",
            favorite: false,
            photo: "goku.jpg"),
                                    Heroe(
                                        id: "2",
                                        name: "krilin",
                                        description: "Mejor amigo de Son Goku",
                                        favorite: false,
                                        photo: "Krilin.jpg")]
        
        MockURLProtocol.requestHandler = { request in
            let data = try? JSONEncoder().encode(someHeroes )
            let response = HTTPURLResponse(
                url: URL(string: "https://dragonball.keepcoding.education")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )
            return (response!, data!)
        }
        
        let expectation = expectation(description: "GetHeroes success")
        
        sut.getHeroes { result in
            switch result {
            case .success(let heroes):
                XCTAssertEqual(heroes, someHeroes)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success but received error: \(error)")
            }
        }
        
        wait(for: [expectation])
        
    }
    
}

final class MockURLProtocol: URLProtocol {
    static var error: ConnectivityModel.ConectivityError?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse,Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        guard let handler = MockURLProtocol.requestHandler else {
            assertionFailure("Received unexpected request with no handler")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
        catch{
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    override func stopLoading() {}
}

