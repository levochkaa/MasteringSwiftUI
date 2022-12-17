// SimpleGE.swift

import SwiftUI

struct SimpleGE: View {

    @Namespace private var shapeTransition
    @State private var expand = false

    var body: some View {
        VStack {
            if expand {
                RoundedRectangle(cornerRadius: 50.0) .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                    .foregroundColor(Color(.systemGreen))
                    .onTapGesture {
                        withAnimation {
                            expand.toggle()
                        }
                    }

            } else {
                Spacer()

                RoundedRectangle(cornerRadius: 50.0) .matchedGeometryEffect(id: "circle", in: shapeTransition) .frame(width: 100, height: 100) .foregroundColor(Color(.systemOrange))
                    .onTapGesture {
                        withAnimation {
                            expand.toggle()
                        }
                    }
            }
        }
    }
}

struct SimpleGE_Previews: PreviewProvider {
    static var previews: some View {
        SimpleGE()
    }
}
