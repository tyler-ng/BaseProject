//
//  AnimalsRequestMock.swift
//  BaseProjectTests
//
//  Created by Tyler on 2024-02-01.
//

import Foundation
@testable import BaseProject

enum AnimalsRequestMock: RequestProtocol {
    case getAnimals
    
    var requestType: RequestType {
        return .GET
    }
    
    var path: String {
        guard let path = Bundle.main.path(forResource: "AnimalsMock", ofType: "json") else {
            return ""
        }
        return path
    }
}
