// ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                TabView(selection: $selection) {
                    Text("Home Tab")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .tag(0)

                    Text("Bookmark Tab")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .tabItem {
                            Image(systemName: "bookmark.circle.fill")
                            Text("Bookmark")
                        }
                        .tag(1)

                    Text("Video Tab")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .tabItem {
                            Image(systemName: "video.circle.fill")
                            Text("Video")
                        }
                        .tag(2)

                    Text("Profile Tab")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        }
                        .tag(3)
                }
                .accentColor(.red)
                .onAppear() {
                    UITabBar.appearance().barTintColor = .white
                }

                Button {
                    selection = (selection + 1) % 4
                } label: {
                    Text("Next")
                        .font(.system(.headline, design: .rounded))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10.0)
                        .padding()
                }
            }
            .navigationTitle("TabView Demo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
