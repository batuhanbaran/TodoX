//
//  TodoXTabView.swift
//  TodoX
//
//  Created by Batuhan Baran on 21.09.2025.
//

import SwiftUI
import NavigatorUI

public struct TodoXTabView: View {
    @State private var selectedTab = 0
    private let onClose: (() -> Void)?

    public init(onClose: (() -> Void)? = nil) {
        self.onClose = onClose
    }

    public var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Main content
                TabView(selection: $selectedTab) {
                    // My Notes Tab
                    HomeView()
                        .tag(0)

                    // Create Tab
                    CreateView()
                        .tag(1)

                    // Favorites Tab
                    FavoritesView()
                        .tag(2)
                }
                .tabViewStyle(.automatic)

                // Custom tab bar
                CustomTabBar(selectedTab: $selectedTab, onClose: onClose)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

// MARK: - Create View
private struct CreateView: View {
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 100, height: 100)
                .overlay {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                }
            Text("Create")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Text("Create new notes and tasks")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .navigationTitle("Create")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Favorites View
private struct FavoritesView: View {
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 100, height: 100)
                .overlay {
                    Image(systemName: "heart")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                }
            Text("Favorites")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Text("Your favorite notes and tasks")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Custom Tab Bar
private struct CustomTabBar: View {
    @Environment(\.navigator) var navigator
    @Binding var selectedTab: Int
    let onClose: (() -> Void)?   // ⬅️ alınan closure

    private let tabs = [
        (title: "My Notes",   icon: "note.text"),
        (title: "Create",     icon: "plus.circle"),
        (title: "Favorites",  icon: "heart"),
        (title: "SupernovaX", icon: "rectangle.portrait.and.arrow.right") // logout/exit action
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs.indices, id: \.self) { index in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        if index == tabs.count - 1 {
                            // Son tab: kapatma/çıkış aksiyonu
                            navigator.dismiss()
                            // selectedTab'ı değiştirmiyoruz, mevcut sekmede kal
                        } else {
                            selectedTab = index
                        }
                    }
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: tabs[index].icon)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(selectedTab == index ? .primary : .gray)

                        Text(tabs[index].title)
                            .font(.caption2)
                            .fontWeight(selectedTab == index ? .medium : .regular)
                            .foregroundColor(selectedTab == index ? .primary : .gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    // İstersen: son tab için farklı stil
                    .opacity(index == tabs.count - 1 ? 0.9 : 1.0)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.1))
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

#Preview {
    TodoXTabView {
        print("onClose çalıştı")
    }
}
