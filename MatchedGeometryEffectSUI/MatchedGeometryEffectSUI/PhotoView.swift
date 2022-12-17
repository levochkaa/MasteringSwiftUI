// PhotoView.swift

import SwiftUI

struct PhotoView: View {

    @State private var swap = true
    @Namespace private var imageTransition

    var body: some View {
        if swap {
            HStack {
                Image("photo1")
                    .resizable()
                    .frame(width: 150, height: 200)
                    .matchedGeometryEffect(id: "firstImage", in: imageTransition)

                Spacer()

                Image("photo2")
                    .resizable()
                    .frame(width: 150, height: 200)
                    .matchedGeometryEffect(id: "secondImage", in: imageTransition)
            }
            .padding()
            .onTapGesture {
                withAnimation {
                    swap.toggle()
                }
            }
        } else {
            HStack {
                Image("photo2")
                    .resizable()
                    .frame(width: 150, height: 200)
                    .matchedGeometryEffect(id: "secondImage", in: imageTransition)

                Spacer()

                Image("photo1")
                    .resizable()
                    .frame(width: 150, height: 200)
                    .matchedGeometryEffect(id: "firstImage", in: imageTransition)
            }
            .padding()
            .onTapGesture {
                withAnimation {
                    swap.toggle()
                }
            }
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
