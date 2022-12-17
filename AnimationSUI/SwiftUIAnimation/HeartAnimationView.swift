//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by Simon Ng on 6/11/2021.
//

import SwiftUI

struct HeartAnimationView: View {
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    
    var body: some View {

        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3), value: circleColorChanged)
            
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 100))
                .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3), value: heartColorChanged)
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        .onTapGesture {
            self.circleColorChanged.toggle()
            self.heartColorChanged.toggle()
            self.heartSizeChanged.toggle()
        }
        
    }
}

struct HeartAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        HeartAnimationView()
    }
}
