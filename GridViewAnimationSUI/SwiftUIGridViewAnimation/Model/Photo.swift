//
//  Photo.swift
//  SwiftUIGridViewAnimation
//
//  Created by Simon Ng on 25/9/2021.
//

import Foundation

struct Photo: Identifiable {
    var id = UUID()
    var name: String
}

let samplePhotos = (1...20).map { Photo(name: "coffee-\($0)") }
