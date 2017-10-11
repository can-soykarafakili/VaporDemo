//
//  CreatePokemonDatabase.swift
//  App
//
//  Created by Can Soykarafakili on 11.10.17.
//

import Foundation
import Vapor
import FluentProvider

final class CreatePokemonDatabase {}

extension CreatePokemonDatabase: Preparation
{
    static func prepare(_ database: Database) throws
    {
        let bulbasaur = Pokemon (name: "Bulbasaur", index: 1, hitPoints: 45, type: "Grass")
        let iyvsaur = Pokemon (name: "Iyvsaur", index: 2, hitPoints: 60, type: "Grass")
        let venusaur = Pokemon (name: "Venusaur", index: 3, hitPoints: 80, type: "Grass")
        
        let charmander = Pokemon (name: "Charmander", index: 4, hitPoints: 39, type: "Fire")
        let charmeleon = Pokemon (name: "Charmeleon", index: 5, hitPoints: 58, type: "Fire")
        let charizard = Pokemon (name: "Charizard", index: 6, hitPoints: 78, type: "Fire")

        let squirtle = Pokemon (name: "Squirtle", index: 7, hitPoints: 44, type: "Water")
        let wartortle = Pokemon (name: "Wartortle", index: 8, hitPoints: 59, type: "Water")
        let blastoise = Pokemon (name: "Blastoise", index: 9, hitPoints: 79, type: "Water")

        let pikachu = Pokemon (name: "Pikachu", index: 25, hitPoints: 35, type: "Electric")
        let raichu = Pokemon (name: "Raichu", index: 26, hitPoints: 35, type: "Electric")
        
        try bulbasaur.save()
        try iyvsaur.save()
        try venusaur.save()
        
        try charmander.save()
        try charmeleon.save()
        try charizard.save()

        try squirtle.save()
        try wartortle.save()
        try blastoise.save()

        try pikachu.save()
        try raichu.save()

    }
    
    static func revert(_ database: Database) throws {}
}
