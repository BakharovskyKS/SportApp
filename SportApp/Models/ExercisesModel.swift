//
//  ExercisesModel.swift
//  SportApp
//
//  Created by Кирилл Бахаровский on 11/10/24.
//

import Foundation

struct ExercisesModel: Codable {
    var name: String?
    var type: String?
    var muscle: String?
    var equipment: String?
    var difficulty: String?
    var instructions: String?
    
    init(name: String? = nil, type: String? = nil, muscle: String? = nil, equipment: String? = nil, difficulty: String? = nil, instructions: String? = nil) {
        self.name = name
        self.type = type
        self.muscle = muscle
        self.equipment = equipment
        self.difficulty = difficulty
        self.instructions = instructions
    }
}
