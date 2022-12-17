//
//  ContentView.swift
//  SwiftUIState
//
//  Created by Simon Ng on 5/11/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 1
    
    var body: some View {
        Button(action: {
            self.counter += 1
        }) {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(.red)
                .overlay {
                    Text("\(counter)")
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
