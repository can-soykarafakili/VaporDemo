//
//  Pokemon.swift
//  App
//
//  Created by Can Soykarafakili on 11.10.17.
//

import Foundation
import Vapor
import FluentProvider

final class Pokemon : Model
{
    let name: String
    let index: Int
    let hitPoints: Int
    let type: String
    let storage = Storage()
    
    struct Keys {
        static let name = "name"
        static let index = "pokedexID"
        static let hitPoints = "hitPoints"
        static let type = "type"
    }
    
    // Creates a  new Pokemon
    init(name: String, index: Int, hitPoints: Int, type: String)
    {
        self.name = name
        self.index = index
        self.hitPoints = hitPoints
        self.type = type
    }

    // MARK: Fluent Serialization
    
    // Initializes the Pokemon from the database row
    init(row: Row) throws
    {
        name = try row.get(Pokemon.Keys.name)
        index = try row.get(Pokemon.Keys.index)
        hitPoints = try row.get(Pokemon.Keys.hitPoints)
        type = try row.get(Pokemon.Keys.type)
    }
    
    // Serializes the Pokemon to the database
    func makeRow() throws -> Row
    {
        var row = Row()
        try row.set(Pokemon.Keys.name, name)
        try row.set(Pokemon.Keys.index, index)
        try row.set(Pokemon.Keys.hitPoints, hitPoints)
        try row.set(Pokemon.Keys.type, type)
        return row
    }
}

// This allows Pokemon models to be returned directly in route closures
extension Pokemon : ResponseRepresentable { }

extension Pokemon : JSONConvertible
{
    func makeJSON() throws -> JSON
    {
        var json = JSON()
        try json.set(Pokemon.Keys.name, name)
        try json.set(Pokemon.Keys.index, index)
        try json.set(Pokemon.Keys.hitPoints, hitPoints)
        try json.set(Pokemon.Keys.type, type)
        return json
    }
    
    convenience init(json: JSON) throws
    {
        self.init(name: try json.get(Pokemon.Keys.name), index: try json.get(Pokemon.Keys.index), hitPoints: try json.get(Pokemon.Keys.hitPoints), type: try json.get(Pokemon.Keys.type))
    }
}

extension Pokemon: Preparation
{
    static func prepare(_ database: Database) throws
    {
        try database.create(self) { pokemons in
            pokemons.id()
            pokemons.string(Pokemon.Keys.name)
            pokemons.int(Pokemon.Keys.index)
            pokemons.int(Pokemon.Keys.hitPoints)
            pokemons.string(Pokemon.Keys.type)
        }
    }
    
    static func revert(_ database: Database) throws
    {
        try database.delete(self)
    }
}
