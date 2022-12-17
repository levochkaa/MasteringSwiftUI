//
//  ScalableView.swift
//  SwiftUIGesture
//
//  Created by Simon Ng on 10/11/2021.
//

import SwiftUI

struct ScalableView<Content>: View where Content: View {
    
    @GestureState private var scaleFactor: CGFloat = 1.0
    
    var content: () -> Content
    
    var body: some View {
        content()
            .scaleEffect(scaleFactor)
            .animation(.default, value: scaleFactor)
            .gesture(MagnificationGesture()
                .updating($scaleFactor, body: { (value, state, transaction) in
                    
                    state = value
                })
            )
    }
}

struct ScalableView_Previews: PreviewProvider {
    static var previews: some View {
        ScalableView() {
            Image(systemName: "headphones")
                .font(.system(size: 100))
                .foregroundColor(.purple)
        }
    }
}
