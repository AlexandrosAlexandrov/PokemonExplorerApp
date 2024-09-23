//
//  View+.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 23/9/24.
//

import SwiftUI

// MARK: Navigation
extension View {
    @ViewBuilder
    func navigate<Destination: View, Content: View>(
        to myView: Destination,
        when isActive: Binding<Bool>,
        @ViewBuilder content: () -> Content = { EmptyView() }
    ) -> some View {
        NavigationLink(isActive: isActive) {
            myView
        } label: {
            content()
        }
        .buttonStyle(NoTapAnimationStyle())
    }
}

// Button Style to not show Default Tap Animation
public struct NoTapAnimationStyle: PrimitiveButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
        //            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}
