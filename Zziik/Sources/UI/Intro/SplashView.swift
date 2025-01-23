//
//  SplashView.swift
//  Zziik
//
//  Created by 구태호 on 1/20/25.
//

import SwiftUI
import Then

struct SplashView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var rotation: Double = 90
    @State private var scale: CGFloat = 2.0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color(._1B1D28))
                .frame(width: 128, height: 128)
                .scaleEffect(scale)
                .rotationEffect(.degrees(rotation))
                .overlay {
                    Image(.imgZziik66)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(32)
                        .scaleEffect(scale)
                        .rotationEffect(.degrees(rotation))
                        .animation(.spring(duration: 0.6), value: rotation)
                }
                .animation(.spring(duration: 1.0), value: scale)
                .onAppear {
                    rotation = 0
                    scale = 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        coordinator.push(destination: .main(tab: .home(tab: .shipping)))
                    }
                }
                .onTapGesture {
                    rotation += 90
                }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.init(hex: "#6B7DB1"))
    }
}

#Preview {
    SplashView()
        .environmentObject(Coordinator())
}
