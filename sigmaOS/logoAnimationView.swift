//
//  logoAnimationView.swift
//  sigmaOS
//
//  Created by Max Chaplin on 07/02/2023.
//

import SwiftUI

struct logoAnimationView: View {
    
    @State var isShowing: Bool = true
    
    @State var isTextAnimated : Bool = false
    @State var isAboutToHide: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(Color("orange"))
                .ignoresSafeArea()
            
            let logoAnimation = VStack(spacing: 15) {
                
                Spacer()
                
                ZStack {
                    
                    newSigmaLogo(isAnimated4: $isTextAnimated, isAnimated6: $isAboutToHide, isAnimated7: $isShowing)
                        .frame(width: 100, height: 100, alignment: .center)
                    
                    Circle()
                        .foregroundColor(.primary)
                        .frame(width: 100, height: 100, alignment: .center)
                        .scaleEffect(isAboutToHide ? 10 : 0.001)
                        .blendMode(.destinationOut)
                    
                }
                
                Text("SigmaOS")
                    .font(Font.system(size: 250 / 10))
                    .foregroundColor(.primary)
                    .rotation3DEffect(.degrees(isTextAnimated ? 0 : -90), axis: (x: 1, y: 0, z: 0))
                    .opacity(isTextAnimated ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 200, damping: 12), value: isTextAnimated)
                    .bold()
                
                Text("For Iphone")
                    .font(Font.system(size: 250 / 20))
                    .foregroundColor(.primary)
                    .rotation3DEffect(.degrees(isTextAnimated ? 0 : -90), axis: (x: 1, y: 0, z: 0))
                    .opacity(isTextAnimated ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 200, damping: 12), value: isTextAnimated)
                
                Spacer()
                
            }
            
            logoAnimation

            
        }
        .compositingGroup()
        .opacity(isShowing ? 1 : 0)
        
        
    }
}

struct newSigmaLogo: View {
    
    var color : Color = .primary
    
    var isTransition: Bool = true
    
    @State var isAnimated : Bool = false
    @State var isAnimated2 : Bool = false
    @State var isAnimated3 : Bool = false
    @Binding var isAnimated4 : Bool
    @State var isAnimated5 : Bool = false
    @Binding var isAnimated6 : Bool
    @Binding var isAnimated7 : Bool
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: geo.size.width * 0.2)
                        .trim(from: 0, to: isAnimated ? 1 : 0)
                        .stroke(color, style: StrokeStyle(lineWidth: geo.size.width / 50))
                        .scaleEffect(0.8)
                        .opacity(isAnimated2 ? 0 : 1)
                    
                    Image("logo")
                        .resizable()
                        .frame(width: geo.size.width, height: geo.size.width)
                        .scaledToFill()
                        .scaleEffect(isAnimated2 ? 1 : 0.5)
                        .opacity(isAnimated2 ? 1 : 0)
                    
                }
                .scaleEffect(isAnimated2 ? 1 : 0.95)
                .animation(.interpolatingSpring(stiffness: 200, damping: 12), value: isAnimated2)
                
                
                
            }
            .frame(width: geo.size.width, height: geo.size.width)
            
            
            
        }
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation(.easeInOut(duration: 0.35)) {
                    isAnimated = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isAnimated2 = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeInOut(duration: 0.75)) {
                    isAnimated3 = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isAnimated4 = true
                }
            }
            
            if isTransition {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        
                        isAnimated3 = false
                        isAnimated4 = false
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isAnimated5 = true
                        isAnimated6 = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isAnimated7 = false
                    }
                }
                
            }
            
        }
    }
    
}

struct logoAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        logoAnimationView()
    }
}
