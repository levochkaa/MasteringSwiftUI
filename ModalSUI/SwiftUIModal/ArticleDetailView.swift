//
//  ArticleDetailView.swift
//  SwiftUIModal
//
//  Created by Simon Ng on 19/8/2020.
//

import SwiftUI

struct ArticleDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    
    var article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(article.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                Group {
                    Text(article.title)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.black)
                        .lineLimit(3)
                        
                    Text("By \(article.author)".uppercased())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 0)
                .padding(.horizontal)
                
                Text(article.content)
                    .font(.body)
                    .padding()
                    .lineLimit(1000)
                    .multilineTextAlignment(.leading)
            }
            
        }
        .overlay(
            
            HStack {
                Spacer()
                
                VStack {
                    Button(action: {
                        self.showAlert = true
                    }, label: {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    })
                    .padding(.trailing, 20)
                    .padding(.top, 40)
                    
                    Spacer()
                }
            }
        )
        .ignoresSafeArea(.all, edges: .top)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Reminder"), message: Text("Are you sure you are finished reading the article?"), primaryButton: .default(Text("Yes"), action: { dismiss() }), secondaryButton: .cancel(Text("No")))
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: articles[0])
    }
}
