//
//  CharacteresList.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 08/08/25.
//

import SwiftUI

struct CharacteresList: View {
    // 1. Create a list of your character data.
    // In a real app, this would likely come from an API call or a database.
    let characters = [
        Character(name: "Spider-Man", imageUrlString: "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8126579-amazing_spider-man_vol_5_54_stormbreakers_variant_textless.jpg"),
        Character(name: "Iron Man", imageUrlString: "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8654427-ezgif-1-2f113089e4.jpg"),
        Character(name: "Batman", imageUrlString: "https://comicvine.gamespot.com/a/uploads/scale_small/11144/111442876/8759934-jrjrhr.jpg"),
        Character(name: "Wolverine", imageUrlString: "https://comicvine.gamespot.com/a/uploads/scale_small/11161/111612243/9575315-3753315455-latest.jpg"),
        Character(name: "Dr Strange", imageUrlString: "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8753901-ezgif-3-69b95d2d1b.jpg"),
        
        Character(name: "Thor", imageUrlString: "https://comicvine.gamespot.com/a/uploads/scale_small/11139/111399535/9140994-20231020_153307~3.jpg"),
   
    ]

    // 2. Define the grid layout.
    // This creates two columns with flexible widths.
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        // 3. Use `ScrollView` to make the grid scrollable.
        ScrollView {
            // 4. Use `LazyVGrid` with your defined columns.
            LazyVGrid(columns: columns) {
                // 5. Loop through your characters to create a `CharacterItem` for each one.
                ForEach(characters) { character in
                    
                    NavigationLink(destination: CharacterDetailsScreen(character: character)) {
                        CharacterItem(imageUrlString: character.imageUrlString)
    
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    CharacteresList()
}
