//
//  AppContainerView.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 29/08/25.
//

import SwiftUI

struct NativeTabView: View {
    
    var body: some View {
        TabView{
            Tab.init("Characters", systemImage: "person.3"){
                NavigationStack{
                    CharactersScreen()
                }
            }
        
            Tab.init("Search", systemImage: "magnifyingglass"){
                NavigationStack{
                    SearchCharacter()
                }
            }
        }
    }
}


#Preview {
    NativeTabView()
}
