//
//  TodoXTabView.swift
//  TodoX
//
//  Created by Batuhan Baran on 21.09.2025.
//

import SwiftUI

public struct TodoXTabView: View {
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
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
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            // Custom futuristic tab bar
            FuturisticTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Create View
private struct CreateView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.cyan, .blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                Text("Create")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.cyan, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
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
}

// MARK: - Favorites View
private struct FavoritesView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "heart.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.pink, .red, .orange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                Text("Favorites")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.pink, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
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
}

// MARK: - Custom Tab Bar
private struct FuturisticTabBar: View {
    @Binding var selectedTab: Int
    @Namespace private var tabIndicator
    
    private let tabs = [
        (title: "My Notes", icon: "note.text", gradient: [Color.green, Color.teal]),
        (title: "Create", icon: "plus.circle", gradient: [Color.cyan, Color.blue]),
        (title: "Favorites", icon: "heart", gradient: [Color.pink, Color.red])
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        selectedTab = index
                    }
                } label: {
                    VStack(spacing: 8) {
                        ZStack {
                            // Background glow effect
                            if selectedTab == index {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: tabs[index].gradient + [Color.clear],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 50, height: 50)
                                    .blur(radius: 8)
                                    .matchedGeometryEffect(id: "tabGlow", in: tabIndicator)
                            }
                            
                            // Icon container
                            Circle()
                                .fill(selectedTab == index ? Color.black.opacity(0.8) : Color.clear)
                                .frame(width: 45, height: 45)
                                .overlay {
                                    Image(systemName: tabs[index].icon)
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundStyle(
                                            selectedTab == index ?
                                            LinearGradient(
                                                colors: tabs[index].gradient,
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ) :
                                            LinearGradient(
                                                colors: [Color.gray],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                }
                        }
                        
                        // Tab title
                        Text(tabs[index].title)
                            .font(.caption)
                            .fontWeight(selectedTab == index ? .semibold : .regular)
                            .foregroundStyle(
                                selectedTab == index ?
                                LinearGradient(
                                    colors: tabs[index].gradient,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ) :
                                LinearGradient(
                                    colors: [Color.gray],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background {
            // Futuristic tab bar background
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.black.opacity(0.9),
                            Color.gray.opacity(0.3),
                            Color.black.opacity(0.9)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                            LinearGradient(
                                colors: [Color.cyan.opacity(0.5), Color.purple.opacity(0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
                .shadow(color: .cyan.opacity(0.3), radius: 10, x: 0, y: 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

#Preview {
    TodoXTabView()
        .preferredColorScheme(.dark)
}
