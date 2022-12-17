// CarouselView.swift

import SwiftUI

struct CarouselView: View {

    @State private var currentCardIndex = 2
    @GestureState private var dragOffset: CGFloat = 0
    @State private var sampleArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(sampleArray, id: \.self) { index in
                RoundedRectangle(cornerRadius: 20)
                    .fill(.gray)
                    .padding(20)
                    .frame(width: UIScreen.main.bounds.width / 1.5, height: currentCardIndex == index ? 250 : 200)
                    .opacity(currentCardIndex == index ? 1.0 : 0.7)
                    .overlay {
                        Text("\(index)")
                    }
            }
        }
        .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height, alignment: .leading)
        .offset(x: -CGFloat(currentCardIndex) * (UIScreen.main.bounds.width / 1.5))
        .offset(x: self.dragOffset)
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, state, transaction in
                    state = value.translation.width
                }
                .onEnded { value in
                    let threshold = UIScreen.main.bounds.width * 0.3
                    var newIndex = Int(-value.translation.width / threshold) + currentCardIndex
                    newIndex = min(max(newIndex, 0), sampleArray.count - 1)
                    currentCardIndex = newIndex
                }
        )
        .ignoresSafeArea()
        .animation(.interpolatingSpring(mass: 0.6, stiffness: 100, damping: 10, initialVelocity: 0.3), value: dragOffset)
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
