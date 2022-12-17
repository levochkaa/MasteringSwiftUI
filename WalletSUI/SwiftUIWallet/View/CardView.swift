//
//  CardView.swift
//  SwiftUIWallet
//
//  Created by Simon Ng on 16/12/2021.
//

import SwiftUI

struct CardView: View {
    var card: Card
    
    var body: some View {
        Image(card.image)
        .resizable()
        .scaledToFit()
            .overlay(
                
                VStack(alignment: .leading) {
                    Text(card.number)
                        .bold()
                    HStack {
                        Text(card.name)
                            .bold()
                        Text("Valid Thru")
                            .font(.footnote)
                        Text(card.expiryDate)
                            .font(.footnote)
                    }
                }
                .foregroundColor(.white)
                .padding(.leading, 25)
                .padding(.bottom, 20)
                
            , alignment: .bottomLeading)
            .shadow(color: .gray, radius: 1.0, x: 0.0, y: 1.0)
    
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(testCards) { card in
                CardView(card: card).previewLayout(.sizeThatFits)
            }
        }
    }
}
