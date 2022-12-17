//
//  DotIndicatorView.swift
//  SwiftUIAnimation
//
//  Created by Simon Ng on 7/11/2021.
//

import SwiftUI

struct DotIndicatorView: View {
    @State private var isLoading = false
    
    var body: some View {
        HStack {
            ForEach(0...4, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.green)
                    .scaleEffect(self.isLoading ? 0 : 1)
                    .animation(.linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)), value: isLoading)
            }
        }
        .onAppear() {
            self.isLoading = true
        }
    }
}

struct DotIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        DotIndicatorView()
    }
}
