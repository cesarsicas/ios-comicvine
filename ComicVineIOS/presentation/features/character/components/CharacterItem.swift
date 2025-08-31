//
//  CharacterItem.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 08/08/25.
//

import SwiftUI

struct CharacterItem: View {
    let imageUrlString: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let imageUrl = URL(string: imageUrlString) {
                    AsyncImage(url: imageUrl) { image in
                        image
                             .resizable()
                             .aspectRatio(contentMode: .fill) // Fills the frame, potentially cropping
                             .frame(width: geometry.size.width, height: geometry.size.width)
                             .clipped()
                             .offset(y: 0)
                    } placeholder: {
                        ProgressView()
                            .frame(width: geometry.size.width, height: geometry.size.width) // Match the placeholder size
                    }
                } else {
                    Text("Invalid URL")
                        .foregroundColor(.red)
                        .frame(width: geometry.size.width, height: geometry.size.width) // Match the text view size
                }
            }
        }
        .aspectRatio(1, contentMode: .fit) 
    }
}


#Preview {
    CharacterItem(imageUrlString: "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8753901-ezgif-3-69b95d2d1b.jpg")
}
