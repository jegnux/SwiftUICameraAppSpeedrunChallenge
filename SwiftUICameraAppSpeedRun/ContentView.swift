//
//  ContentView.swift
//  SwiftUICameraAppSpeedRun
//
//  Created by Jérôme Alves on 23/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            topBar
            viewer
            bottomBar
        }
        .background(
            background
        )
    }
    
    @ViewBuilder var topBar: some View {
        HStack {
            Circle()
                .stroke(.white.opacity(0.15))
                .frame(width: 24, height: 24)
                .overlay(
                    Image(systemName: "bolt.fill")
                        .imageScale(.small)
                )
            Spacer()
            Image(systemName: "chevron.up.circle.fill")
                .resizable()
                .frame(width: 28, height: 28)
            Spacer()
            Image(systemName: "livephoto")
                .resizable()
                .frame(width: 24, height: 24)
        }
        .padding(EdgeInsets(top: -6, leading: 12, bottom: 53, trailing: 12))
        .foregroundStyle(.white, .white.opacity(0.15))
        .background(.black.opacity(0.5))
    }
    
    @ViewBuilder var viewer: some View {
        ZStack {
            
            GeometryReader { geometry in
                let lineWidth: CGFloat = 1
                let length: CGFloat = 25
                Path { path in
                    let rect = geometry.frame(in: .local).insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
                    
                    path.addLines([
                        CGPoint(x: rect.minX, y: rect.minY + length),
                        CGPoint(x: rect.minX, y: rect.minY),
                        CGPoint(x: rect.minX + length, y: rect.minY),
                    ])

                    path.addLines([
                        CGPoint(x: rect.maxX, y: rect.minY + length),
                        CGPoint(x: rect.maxX, y: rect.minY),
                        CGPoint(x: rect.maxX - length, y: rect.minY),
                    ])

                    path.addLines([
                        CGPoint(x: rect.minX, y: rect.maxY - length),
                        CGPoint(x: rect.minX, y: rect.maxY),
                        CGPoint(x: rect.minX + length, y: rect.maxY),
                    ])

                    path.addLines([
                        CGPoint(x: rect.maxX, y: rect.maxY - length),
                        CGPoint(x: rect.maxX, y: rect.maxY),
                        CGPoint(x: rect.maxX - length, y: rect.maxY),
                    ])

                }
                .stroke(Color.white.opacity(0.75), lineWidth: lineWidth)
            }
            
            HStack {
                Circle()
                    .fill(.black.opacity(0.25))
                    .frame(width: 24, height: 24)
                    .overlay(
                        Text("0,5")
                            .font(.caption2)
                            .bold()
                            .foregroundColor(.white)
                    )
                Circle()
                    .fill(.black.opacity(0.25))
                    .frame(width: 38, height: 38)
                    .overlay(
                        Text("1×")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.yellow)
                    )
                Circle()
                    .fill(.black.opacity(0.25))
                    .frame(width: 24, height: 24)
                    .overlay(
                        Text("3")
                            .font(.caption2)
                            .bold()
                            .foregroundColor(.white)
                    )
            }
            .padding(4)
            .background(
                Capsule()
                    .fill(.black.opacity(0.15))
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding()
        }
    }
    
    enum CaptureMode: String, CaseIterable {
        case cinematic, video, photo, portrait, pano
    }
    
    @State var captureMode: CaptureMode = .photo
    @ViewBuilder var bottomBar: some View {
        VStack {
            
            Text("PLACEHOLDER")
                .frame(maxWidth: .infinity)
                .opacity(0)
                .overlay(
                    HStack(spacing: 24) {
                        ForEach(CaptureMode.allCases, id: \.rawValue) { mode in
                            Button(mode.rawValue.uppercased()) {
                                withAnimation {
                                captureMode = mode
                                }
                            }
                            .foregroundColor(captureMode == mode ? .yellow : .white)
                            .alignmentGuide(captureMode == mode ? .captureMode : .center) { dimensions in
                                dimensions.width / 2
                            }
                        }
                    }
                        .fixedSize(),
                    alignment: Alignment(horizontal: .captureMode, vertical: .center)
                )
            .font(.caption.weight(.bold))
            .padding(.vertical, 12)
            .mask(
                LinearGradient(
                    stops: [
                        .init(color: .black.opacity(0), location: 0),
                        .init(color: .black, location: 0.1),
                        .init(color: .black, location: 0.9),
                        .init(color: .black.opacity(0), location: 1),
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                    )
            )
            
            
            HStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 49, height: 49)
                    .cornerRadius(4)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 60, height: 60)
                    
                    Circle()
                        .stroke(.white, lineWidth: 4)
                        .frame(width: 68, height: 68)
                }
                
                Spacer()
                
                Circle()
                    .fill(.white.opacity(0.15))
                    .frame(width: 48, height: 48)
                    .overlay(Image(systemName: "arrow.triangle.2.circlepath"))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 50)
        }
        .foregroundStyle(.white, .white.opacity(0.15))
        .background(.black.opacity(0.5))
    }
    
    @ViewBuilder var background: some View {
        Image("background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
    
    
}

extension HorizontalAlignment {
    struct CaptureModeAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.width / 2
        }
    }
    
    static let captureMode = HorizontalAlignment(CaptureModeAlignment.self)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
