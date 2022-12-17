//
//  ContentView.swift
//  SwiftUIBottomSheet
//
//  Created by Simon Ng on 1/9/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showDetail = false
    @State private var selectedRestaurant: Restaurant?
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(restaurants) { restaurant in
                        BasicImageRow(restaurant: restaurant)
                            .onTapGesture {
                                self.showDetail = true
                                self.selectedRestaurant = restaurant
                            }
                    }
                }
                .listStyle(.plain)
                
                .navigationBarTitle("Restaurants")
            }
            .offset(y: showDetail ? -100 : 0)
            .animation(.easeOut(duration: 0.2))
            
            if showDetail {
                
                BlankView(bgColor: .black)
                        .opacity(0.5)
                        .onTapGesture {
                            self.showDetail = false
                        }
                
                if let selectedRestaurant = selectedRestaurant {
                    RestaurantDetailView(restaurant: selectedRestaurant, isShow: $showDetail)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BasicImageRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            Text(restaurant.name)
        }
    }
}

struct BlankView : View {
    
    var bgColor: Color
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}
