//
//  ContentView.swift
//  SearchableDemo
//
//  Created by Simon Ng on 21/6/2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.isSearching) private var isSearching: Bool
    
    @State var articles = sampleArticles
    @State private var searchText = ""
    
    @State var searchResult: [Article] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(articles) { article in
                    ArticleRow(article: article)
                }

                .listRowSeparator(.hidden)

            }
            .listStyle(.plain)
            
            
            .navigationTitle("AppCoda")
            
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search...")) {
            Text("SwiftUI").searchCompletion("SwiftUI")
            Text("iOS 15").searchCompletion("iOS 15")
        }
        
        .onChange(of: searchText) { searchText in
            
            print("onChange called: \(searchText) | \(isSearching)")
            if !searchText.isEmpty {
                articles = sampleArticles.filter { $0.title.contains(searchText) }
            } else {
                articles = sampleArticles
            }
        }
//        .onSubmit(of: .search) {
//            if isSearching && !searchText.isEmpty {
//                articles = sampleArticles.filter { $0.title.contains(searchText) }
//            } else {
//                articles = sampleArticles
//            }
//        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ArticleRow: View {
    let article: Article
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: article.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
                
            } placeholder: {
                Color.purple.opacity(0.1)
            }
            .frame(width: 100, height: 100)
            .cornerRadius(20)
            
            Text(article.title)
                .font(.system(.headline, design: .rounded))
            
        }
    }
}
