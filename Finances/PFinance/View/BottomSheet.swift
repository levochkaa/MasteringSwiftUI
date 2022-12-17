//
//  BottomSheet.swift
//  PFinance
//
//  Created by Simon Ng on 12/9/2020.
//

import SwiftUI

enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .dragging:
            return true
        case .inactive, .pressing:
            return false
        }
    }
    
}

struct BottomSheet<Content>: View where Content: View  {
    
    enum ViewState {
        case full
        case half
    }
    
    @GestureState private var dragState = DragState.inactive
    @State private var positionOffset: CGFloat = 0.0
    @State private var viewState = ViewState.half
    @State private var scrollOffset: CGFloat = 0.0
    
    @Binding var isShow: Bool
    
    let content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                HandleBar()
                
                ScrollView(.vertical) {
                    
                    GeometryReader { scrollViewProxy in
                        Color.clear.preference(key: ScrollOffsetKey.self, value: scrollViewProxy.frame(in: .named("scrollview")).minY)
                    }
                    .frame(height: 0)
                    
                    self.content()
                }
                .background(Color(.systemBackground))
                .cornerRadius(10, antialiased: true)
                .disabled(self.viewState == .half)
                .coordinateSpace(name: "scrollview")
                
            }
            .offset(y: geometry.size.height/2 + self.dragState.translation.height + self.positionOffset)
            .offset(y: self.scrollOffset)
            .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            .edgesIgnoringSafeArea(.all)
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                if self.viewState == .full {
                    self.scrollOffset = value > 0 ? value : 0

                    if self.scrollOffset > 120 {
                        self.positionOffset = 0
                        self.viewState = .half
                        self.scrollOffset = 0
                    }
                }
            }
            .gesture(DragGesture()
                .updating(self.$dragState, body: { (value, state, transaction) in
                    state = .dragging(translation: value.translation)
                    })
                .onEnded({ (value) in
                    
                    if self.viewState == .half {
                        // Threshold #1
                        // Slide up and when it goes beyond the threshold
                        // change the view state to fully opened by updating
                        // the position offset
                        if value.translation.height < -geometry.size.height * 0.25 {
                            self.positionOffset = -geometry.size.height/2 + 50
                            self.viewState = .full
                        }
                        
                        // Threshold #2
                        // Slide down and when it goes pass the threshold
                        // dismiss the view by setting isShow to false
                        if value.translation.height > geometry.size.height * 0.3 {
                            self.isShow = false
                        }
                    }
                  
                })
            )
        }
    }
}


struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(isShow: .constant(true)) {
            Text("Payment Details")
        }
        .background(Color.black.opacity(0.3))
        .edgesIgnoringSafeArea(.all)
    }
}

struct HandleBar: View {
    
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 5)
            .foregroundColor(Color(.systemGray5))
            .cornerRadius(10)
    }
}


struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
