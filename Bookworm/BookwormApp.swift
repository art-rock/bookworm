//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Murilo Lemes on 20/02/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
