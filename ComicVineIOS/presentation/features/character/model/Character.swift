//
//  Character.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 08/08/25.
//
import Foundation

struct Character : Identifiable, Equatable {
    let id = UUID() // This makes the struct Identifiable
    let name: String
    let aliases: String
    let imageUrl: String
    let description:String
}
