import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        get("info") { req in
            return req.description
        }
        
        get("listAllPokemons") { req in
            return try Pokemon.all().makeJSON()
        }
        
        get("pokemon", Int.parameter) { req in
            let pokedexID = try req.parameters.next(Int.self)
            guard let pokemon = try Pokemon.makeQuery().filter(Pokemon.Keys.index, pokedexID).first() else { throw Abort.badRequest }
            return pokemon
        }
        
        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
}
