//
//  TestOperationDelegate.swift
//  TWGOperations
//
//  Created by Nicholas Kuhne on 2016-11-23.
//  Copyright © 2016 Nicholas Kuhne. All rights reserved.
//

class TestOperationDelegate<ResultType> : NSObject, TWGOperationDelegate {
	var completed = false
	var result : ResultType?

	var failed = false
	var error : Error?
	
	func operationDidComplete(operation: TWGOperation, withResult result: Any?) {
		self.completed = true
		if let typedResult = result as? ResultType {
			self.result = typedResult
		}
	}
	func operationDidFail(operation: TWGOperation, withError error: Error?) {
		self.failed = true
		self.error = error
	}
}

class SwiftOperation<ResultType> : TWGOperation {
	var result : ResultType?
	var error : Error?
	var shouldError = false
	
	convenience init(withResult: ResultType) {
		self.init(withResult : withResult, error : nil)
		self.shouldError = false
	}
	
	convenience init(withError: Error) {
		self.init(withResult : nil, error : withError)
		self.shouldError = true
	}
	
	init(withResult result: ResultType?, error: Error?) {
		self.result = result
		self.error = error
		super.init()
	}
	
	override func execute() {
		if self.shouldError {
			self.finish(withError: self.error)
		}
		else {
			self.finish(withResult: self.result)
		}
	}
}
