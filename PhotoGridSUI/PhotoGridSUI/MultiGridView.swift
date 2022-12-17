// MultiGridView.swift

import SwiftUI

struct MultiGridView: View {

    @State private var gridLayout = [GridItem()]
    @State private var showCoffee = false

    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(sampleCafes) { cafe in
                        Image(cafe.image)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(maxHeight: 150)
                            .cornerRadius(10)
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                        if showCoffee {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                                ForEach(cafe.coffeePhotos) { photo in
                                    Image(photo.name)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 50)
                                        .cornerRadius(10)
                                        .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
                                        .animation(.easeIn, value: gridLayout.count)
                                }
                            }
                        }
                    }
                }
                .padding(10)
                .animation(.interactiveSpring(), value: gridLayout.count)
            }
            .navigationTitle("Coffee Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            showCoffee.toggle()
                        }
                    } label: {
                        Image(systemName: "squares.below.rectangle")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        var minWidth: CGFloat {
                            // iPhone landscape mode
                            if verticalSizeClass == .compact {
                                return 250.0
                            }
                            // iPad
                            if horizontalSizeClass == .regular && verticalSizeClass == .regular {
                                return 500.0
                            }
                            return 100.0
                        }

                        self.gridLayout = self.gridLayout.count == 1 ? [
                            GridItem(.adaptive(minimum: minWidth)),
                            GridItem(.flexible()) ] : [ GridItem() ]
                    } label: {
                        Image(systemName: "square.grid.3x2")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
//        .onChange(of: verticalSizeClass) { value in
//            gridLayout = [
//                GridItem(.adaptive(minimum: value == .compact ? 100 : 250)),
//                GridItem(.flexible())
//            ]
//        }
        .onAppear {
            switch (horizontalSizeClass, verticalSizeClass) {
                case (.compact, .regular):
                    // iPhone Portrait
                    gridLayout = [GridItem()]
                case (.compact, _):
                    // iPhone Landscape
                    gridLayout = [GridItem(.adaptive(minimum: 250)), GridItem(.flexible())]
                case (.regular, .regular):
                    // iPad
                    gridLayout = [GridItem(.adaptive(minimum: 500)), GridItem(.flexible())]
                default:
                    break
            }
        }
    }
}

struct MultiGridView_Previews: PreviewProvider {
    static var previews: some View {
        MultiGridView()
    }
}
