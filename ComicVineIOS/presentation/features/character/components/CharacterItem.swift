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
         ZStack {
             // 2. Create the URL object from the string here
             if let imageUrl = URL(string: imageUrlString) {
                 AsyncImage(url: imageUrl) { image in
                     image
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                 } placeholder: {
                     ProgressView()
                 }
             } else {
                 // 3. Handle cases where the URL string is invalid
                 Text("Invalid URL")
                     .foregroundColor(.red)
             }
         }
     }

}

#Preview {
    CharacterItem(imageUrlString: "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8753901-ezgif-3-69b95d2d1b.jpg")
}
