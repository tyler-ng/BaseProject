//
//  Animal+CoreData.swift
//  BaseProject
//
//  Created by Tyler on 2024-05-19.
//

import CoreData

// MARK: - AnimalEntity Properties
extension AnimalEntity {
    var age: Age {
        get {
            guard let ageValue = ageValue,
                  let age = Age(rawValue: ageValue) else {
                return Age.unknown
            }
            return age
        }
        set {
            self.ageValue = newValue.rawValue
        }
    }
}
