//
//  SearchListView.swift
//  SearchableDemo
//
//  Created by Simon Ng on 22/6/2021.
//

import SwiftUI

struct SearchListView: View {
    
    @State var articles = sampleArticles
    @State private var searchText = ""
    
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
        .searchable(text: $searchText)
        .onChange(of: searchText) { searchText in
            
            if !searchText.isEmpty {
                articles = sampleArticles.filter { $0.title.contains(searchText) }
            } else {
                articles = sampleArticles
            }
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}

