// TripDetailView.swift

import SwiftUI

struct TripDetailView: View {
    let destination: String

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(destination)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)

                        HStack(spacing: 3) {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 15))
                            }

                            Text("5.0")
                                .font(.headline)
                                .padding(.leading, 10)
                        }

                        VStack(alignment: .leading) {
                            Text("Desription")
                                .font(.headline)
                                .fontWeight(.medium)
                            Text("Growing up in Michigan, I was lucky enough to experi ence one part of the Great Lakes. And let me assure you, they are great. As a phot ojournalist, I have had endless opportunities to travel the world and to see a var iety of lakes as well as each of the major oceans. And let me tell you, you will be hard pressed to find water as beautiful as the Great Lakes.")
                        }
                        .padding(.vertical, 20)

                        Button {
                            //
                        } label: {
                            Text("Book Now")
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.heavy)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.97, green: 0.369, blue: 0.212))
                                .cornerRadius(20)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                    .background(.white)
                    .cornerRadius(15)

                    Image(systemName: "bookmark.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color(red: 0.97, green: 0.369, blue: 0.212))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .offset(x: -15, y: -5)
                }
                .offset(y: 15)
            }
        }
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailView(destination: "London")
            .background(.black)
    }
}
