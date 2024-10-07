//
//  Loader.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 8/10/24.
//

import SwiftUI

struct Loader: View {
    @Binding var showLoader: Bool
    
    var body: some View {
        if showLoader {
            ProgressView()
                .padding()
        }
    }
}
