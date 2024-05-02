//
//  AddBookView.swift
//  Bookworm
//
//  Created by Murilo Lemes on 22/02/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    @State private var showingValidationAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Historic", "Biography"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    HStack {
                        Text("Rating")
                        Spacer()
                        RatingView(rating: $rating)
                    }
                }
                
                Section {
                    Button("Save") {
                        validateFields()
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Empty title", isPresented: $showingValidationAlert) {
                Button("OK") { }
            } message: {
                Text("The name of the book cannot be empty!")
            }
        }
    }
    
    func validateFields() {
        if author.isEmpty {
            author = "Unknown author"
        }
        if review.isEmpty {
            review = "No review"
        }
        
        if title.isEmpty {
            showingValidationAlert = true
        } else {
            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
            modelContext.insert(newBook)
            dismiss()
        }
    }
}

#Preview {
    AddBookView()
}
