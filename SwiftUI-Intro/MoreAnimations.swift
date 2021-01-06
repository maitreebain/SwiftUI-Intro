//
//  MoreAnimations.swift
//  SwiftUI-Intro
//
//  Created by Maitree Bain on 1/6/21.
//  Copyright © 2021 Maitree Bain. All rights reserved.
//

import SwiftUI

struct MoreAnimations: View {
    @State var point: CGPoint = .zero
    var body: some View {
        
        ZStack {
            Circle()
                .fill(Color.green)
                .frame(width: 50, height: 50)
                .offset(x: point.x, y: point.y)
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.gray)
        .gesture(DragGesture().onChanged { gesture in
            withAnimation(.interactiveSpring(response: 0.1, dampingFraction: 0.05)) { self.point = gesture.location
            }
        })
    }
}

struct MoreAnimations_Previews: PreviewProvider {
    static var previews: some View {
        MoreAnimations()
    }
}
