//
//  WeatherServiceTestCase.swift
//  AnAmericanDreamTests
//
//  Created by Hugues Fils Caparos on 11/05/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//
//

import XCTest
@testable import AnAmericanDream

class FakeWeatherResponseData {
    // MARK: - Data
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let weatherIncorrectData = "wrong".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://random.com")!,
                                            statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://random.com")!,
                                            statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    class WeatherError: Error {}
    static let error = WeatherError()
}

// MARK: - Tests
class ClassWeatherTests: XCTestCase {
    func testGetWeatherShouldUrlError() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        weatherService.getWeather(defaultLocation: nil, latitude: -56.00, longitude: -46.00) { (weather, error) in
            // Then
           XCTAssertNotNil(error)
            XCTAssertNil(weather)
        }
    }

    func testGetWeatherShouldPostFailedCallback() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(defaultLocation: "", latitude: 0.00, longitude: 0.00) { (weather, error) in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(weather)
            XCTAssert(error is FakeWeatherResponseData.WeatherError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoResponse() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(defaultLocation: "", latitude: 0.00, longitude: 0.00) { (weather, error) in
            // Then
            XCTAssertFalse(error is FakeWeatherResponseData)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: FakeWeatherResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(defaultLocation: "", latitude: 0.00, longitude: 0.00) { (weather, error) in
            // Then
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherCorrectData,
                response: FakeWeatherResponseData.responseKO,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(defaultLocation: "", latitude: 0.00, longitude: 0.00) { (weather, error) in
            // Then
            XCTAssertFalse((weather != nil))
            XCTAssertFalse(error is FakeWeatherResponseData.WeatherError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherIncorrectData,
                response: FakeWeatherResponseData.responseOK,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(defaultLocation: "", latitude: 0.00, longitude: 0.00) { (weather, error) in
            // Then
            XCTAssertFalse(weather != nil)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeWeatherResponseData.weatherCorrectData,
                response: FakeWeatherResponseData.responseOK,
                error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(defaultLocation: "", latitude: 0.00, longitude: 0.00) { (weather, error) in
            // Then
            XCTAssertFalse((error != nil))
            XCTAssertNotNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
