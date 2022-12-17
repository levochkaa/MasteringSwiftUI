//
//  RestaurantDetailView.swift
//  SwiftUIBottomSheet
//
//  Created by Simon Ng on 8/12/2021.
//

import SwiftUI

struct RestaurantDetailView: View {
    enum ViewState {
        case full
        case half
    }
    
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
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
        
    }
    
    @GestureState private var dragState = DragState.inactive
    @State private var positionOffset: CGFloat = 0.0
    @State private var viewState = ViewState.half
    @State private var scrollOffset: CGFloat = 0.0
    
    @GestureState private var isPressed = false
    
    let restaurant: Restaurant
    
    @Binding var isShow: Bool
    
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
                    
                    TitleBar()
                    
                    HeaderView(restaurant: self.restaurant)
                    
                    DetailInfoView(icon: "map", info: self.restaurant.location)
                        .padding(.top)
                    DetailInfoView(icon: "phone", info: self.restaurant.phone)
                    DetailInfoView(icon: nil, info: self.restaurant.description)
                        .padding(.top)
                        .padding(.bottom, 100)

                }
                .background(Color.white)
                .cornerRadius(10, antialiased: true)
                .disabled(self.viewState == .half && self.dragState.translation.height == 0)
                .coordinateSpace(name: "scrollview")
                
            }
            .offset(y: geometry.size.height/2 + self.dragState.translation.height + self.positionOffset)
            .offset(y: self.scrollOffset)
            .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            .edgesIgnoringSafeArea(.all)
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
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                if self.viewState == .full {
                    self.scrollOffset = value > 0 ? value : 0

                    if self.scrollOffset > 120 {
                        self.positionOffset = 0
                        self.scrollOffset = 0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.viewState = .half
                        }
                    }
                }
            }
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: restaurants[0], isShow: .constant(true))
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

struct TitleBar: View {
    
    var body: some View {
        HStack {
            Text("Restaurant Details")
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding()
    }
}

struct HeaderView: View {
    let restaurant: Restaurant
    
    var body: some View {
        Image(restaurant.image)
            .resizable()
            .scaledToFill()
            .frame(height: 300)
            .clipped()
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(restaurant.name)
                            .foregroundColor(.white)
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                        
                        Text(restaurant.type)
                            .font(.system(.headline, design: .rounded))
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(5)
                        
                    }
                    Spacer()
                }
                .padding()
            )
    }
}

struct DetailInfoView: View {
    let icon: String?
    let info: String
    
    var body: some View  {
        HStack {
            if icon != nil {
                Image(systemName: icon!)
                    .padding(.trailing, 10)
            }
            Text(info)
                .font(.system(.body, design: .rounded))
            
            Spacer()
        }.padding(.horizontal)
    }
}

struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
