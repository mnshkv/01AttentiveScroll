//
//  ContentView.swift
//  01AttentiveScroll
//
//  Created by Aleksandr Menshikov on 01.05.2024.
//

import SwiftUI

extension View {
    func onLayout(size: Binding<CGSize>) -> some View {
        self
            .overlay {
                GeometryReader { geo in
                    // MARK: - Empty не вызывает onAppear
                    Rectangle()
                        .opacity(0)
                        // MARK: - высталение размера при layout
                        .onAppear(perform: {
                            size.wrappedValue = geo.size
                        })
                        // MARK: - выставление размеров при изменении
                        .onChange(of: geo.size) { oldValue, newValue in
                            size.wrappedValue = newValue
                        }
                }
            }
    }
}

struct ContentView: View {
    @State var rectangleSize: CGSize = .zero

    var body: some View {
        TabView {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(1...100, id: \.self) { index in
                            Text("\(index)")
                                .font(.title)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .contentMargins(.bottom, rectangleSize.height)
                .overlay {
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(Color.red.opacity(0.3))
                            .frame(height: 50)
                            .onLayout(size: $rectangleSize)
                    }
                }
            }
            .tabItem { Label("First", systemImage: "star") }
        }
    }
}

#Preview {
    ContentView()
}
