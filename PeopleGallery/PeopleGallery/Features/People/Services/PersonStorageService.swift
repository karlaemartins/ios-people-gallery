//
//  PersonStorageService.swift
//  PeopleGallery
//
//  Created by Karla E. Martins Fernandes on 09/06/26.
//

import Foundation

final class PersonStorageService {

    func save(people: [Person]) {
        
        let jsonEncoder = JSONEncoder()

        guard let savedData = try? jsonEncoder.encode(people) else {
            return
        }

        UserDefaults.standard.set(savedData, forKey: "people")
    }

    func loadPeople() -> [Person] {
        
        let defaults = UserDefaults.standard

        guard let savedPeople = defaults.object(forKey: "people") as? Data else {
            return []
        }

        let jsonDecoder = JSONDecoder()

        do {
            return try jsonDecoder.decode([Person].self, from: savedPeople)
        } catch {
            return []
        }
    }
}
