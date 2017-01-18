//
//  TWGOperationSwiftCompatibilityTests.swift
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-11-23.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

import XCTest

class TWGOperationSwiftCompatibilityTests: XCTestCase {
	
	let operationQueue = OperationQueue()

	func testCreatingABasicOperationInSwift() {
		let operation = TWGOperation()
		XCTAssert(operation.isExecuting == false)
	}
	
	func testRunningABasicOperationInSwift() {
		let operation = TWGOperation()
		self.operationQueue.addOperations([operation], waitUntilFinished: true)
		XCTAssert(operation.isFinished == true)
	}
	
	func testBeingAnOperationDelegateInSwift() {
		let delegate = TestOperationDelegate<Any>()
		let operation = TWGOperation()
		operation.delegate = delegate
		self.operationQueue.addOperations([operation], waitUntilFinished: true)
		
		XCTAssert(delegate.completed == true)
		XCTAssert(delegate.result == nil)
		XCTAssert(delegate.failed == false)
		XCTAssert(delegate.error == nil)
	}
	
	func testSwiftOperationSubclassSuccess() {
		let result = "Result"
		let operation = SwiftOperation(withResult:result)
		
		let delegate = TestOperationDelegate<String>()
		operation.delegate = delegate
		
		self.operationQueue.addOperations([operation], waitUntilFinished: true)
		
		XCTAssert(delegate.completed == true)
		XCTAssert(delegate.result == result)
		XCTAssert(delegate.failed == false)
		XCTAssert(delegate.error == nil)
	}
	
	func testSwiftOperationSubclassError() {
		class GenericError : Error {
		}
		
		let error = GenericError()
		let operation = SwiftOperation<Any>(withError:error)
		
		let delegate = TestOperationDelegate<Any>()
		operation.delegate = delegate
		
		self.operationQueue.addOperations([operation], waitUntilFinished: true)
		
		XCTAssert(delegate.completed == false)
		XCTAssert(delegate.result == nil)
		XCTAssert(delegate.failed == true)
		if let genericError = delegate.error as? GenericError {
			XCTAssert(genericError === error)
		}
		else {
			XCTFail()
		}
	}
	
	func testSwiftOperationSuccessWithClosures() {
		let result = "Result"
		let operation = SwiftOperation(withResult:result)
		var capturedResult : String? = nil
		
		operation.completion({ (result : Any) in
			if let string = result as? String {
				capturedResult = string
			}
		})
		
		self.operationQueue.addOperations([operation], waitUntilFinished: true)
		
		XCTAssert(capturedResult == result)
	}
	
	func testSwiftOperationFailureWithClosures() {
		class GenericError : Error {
		}
		let error = GenericError()
		let operation = SwiftOperation<Any>(withError:error)
		var capturedError : GenericError? = nil
		
		operation.failure({ (error : Error?) in
			if let genericError = error as? GenericError {
				capturedError = genericError
			}
		})
		
		self.operationQueue.addOperations([operation], waitUntilFinished: true)
		
		if let capturedError = capturedError {
			XCTAssert(capturedError === error)
		}
		else {
			XCTFail()
		}
	}
}
