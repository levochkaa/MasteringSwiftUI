//
//  ContentView.swift
//  SwiftUINavigation
//
//  Created by Simon Ng on 19/10/2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            List(articles) { article in
                ZStack {
                    
                    ArticleRow(article: article)
                    
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        EmptyView()
                    }
                    .opacity(0)
                    
                }
                
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
            .navigationBarTitle("Your Reading")
        }
 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ArticleRow: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(article.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
            
            Text(article.title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .lineLimit(3)
                .padding(.bottom, 0)
            
            Text("By \(article.author)".uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 0)
            
            HStack(spacing: 3) {
                ForEach(1...(article.rating), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            
            Text(article.excerpt)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
    }
}
