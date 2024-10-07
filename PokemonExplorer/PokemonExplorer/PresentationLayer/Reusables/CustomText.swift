//
//  CustomText.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 6/10/24.
//

import Foundation
import SwiftUI

struct CustomText: View {
    let constant: Strings
    let text: String?
    
    init(_ constant: Strings) {
        self.constant = constant
        self.text = nil
    }
    
    init(_ text: String) {
        self.constant = .empty
        self.text = text
    }

    var body: some View {
        if text == nil {
            Text(constant.rawValue)
        } else {
            Text(text ?? "")
        }
    }
}
