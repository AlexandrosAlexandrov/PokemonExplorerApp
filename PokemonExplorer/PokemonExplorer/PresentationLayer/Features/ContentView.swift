//
//  ContentView.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .padding()
            Text("Welcome to Pokémon Explorer!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
