//
//  ModelData.swift
//  Landmarks
//
//  Created by Don Truong on 11/3/21.
//

import Foundation

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in the bundle!")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename)!")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename)!")
    }
}
