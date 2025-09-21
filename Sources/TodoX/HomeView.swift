//
//  HomeView.swift
//  
//
//  Created by Batuhan Baran on 18.09.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var items: [String] = ["Buy milk", "Call mom"]
    @State private var text: String = ""

    var body: some View {
        List {
            Section {
                HStack(spacing: 8) {
                    TextField("Add a task", text: $text)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        let t = text.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !t.isEmpty else { return }
                        items.insert(t, at: 0)
                        text = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Add task")
                }
                .padding(.vertical, 4)
            }

            Section("My Tasks") {
                ForEach(items, id: \.self) { t in
                    HStack {
                        Image(systemName: "checklist")
                        Text(t)
                        Spacer()
                    }
                }
                .onDelete { idx in items.remove(atOffsets: idx) }
            }
        }
        .animation(.default, value: items)
        .navigationTitle("My Notes")
    }
}

#Preview {
    HomeView()
}
