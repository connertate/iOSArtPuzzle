//
//  ContentView.swift
//  Art Puzzle
//
//  Created by Conner Tate on 12/2/22.
//

import SwiftUI
import ConfettiSwiftUI

struct MainView: View {
    @EnvironmentObject var vm: ViewModel
    //iPhone
    @State var scale: CGFloat = 1.45
    //iPad
//    @State var scale: CGFloat = 3.5
    
    var body: some View {
        ZStack {
            Color(0xF2EAD9)
                .ignoresSafeArea()
            
            if(vm.selectedArt == nil) {
                LevelSelectionView()
                    .transition(.opacity)
            } else {
                SquareGridView(vm: vm)
                    .scaleEffect(scale)
                    .confettiCannon(counter: $vm.confettiCounter, num: 100)
                    .transition(.opacity)
                
                //Button layer
                VStack(spacing: 5) {
                    Text(vm.selectedArt?.title ?? "")
                        .font(Font.custom("Avenir Next", size: 35).weight(.semibold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.top, 30)

                    Text(vm.selectedArt?.artist ?? "")
                        .font(Font.custom("Courier", size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
//                    TimerView()
//                        .padding(.bottom, 20)
                    
                    
                    HStack {
                        Image(systemName: "arrow.backward.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.black)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.75)) {
                                    vm.GoHome()
                                    vm.SolvePuzzle()
                                }
                            }
                        
//                        Spacer()
//                        
//                        Image(systemName: "bolt.circle")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(.black)
//                            .onTapGesture {
//                                withAnimation(.easeInOut(duration: 1.0)) {
//                                    vm.SolvePuzzle()
//                                }
//                            }
                        
                        Spacer()
                        
                        Image(systemName: "repeat.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.black)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    vm.ScramblePuzzle()
                                }
                            }
                    }
                    .padding()
                }
                .transition(.opacity)
            }
        }
    }
}

struct SquareGridView: View {
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        ZStack() {
            ForEach(vm.pixels) { pixel in
                ZStack {
                    PixelView(vm: vm, index: pixel.index)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                vm.TappedPixel(index: pixel.index)
                            }
                        }
                }
            }
        }
    }
}

struct PixelView: View {
    
    @ObservedObject var vm: ViewModel
    var index: Int
    var pixelSize: CGFloat = 50.0
    
    var xIndex: Int {
        return index % 5
    }
    
    var yIndex: Int {
        let remainder = index % 5
        let times = (index - remainder) / 5
        return times
    }
    
    var xOffset: CGFloat {
        return ((CGFloat(xIndex) * pixelSize) - pixelSize * 2.0) + (CGFloat(vm.pixels[index].offsetX) * 50.0)
    }
    
    var yOffset: CGFloat {
        return ((CGFloat(yIndex) * pixelSize) - pixelSize * 2.0) + (CGFloat(vm.pixels[index].offsetY) * 50.0)
    }
    
    var body: some View {
        ZStack {
            Image("\(vm.selectedArt?.file ?? "")\(index)")
                .resizable()
                .frame(width: pixelSize, height: pixelSize)
                .cornerRadius(vm.pixels[index].offsetX == 0 && vm.pixels[index].offsetY == 0 ? 0 : 10)
            
            if(vm.selecedPixel == index) {
                Image(systemName: "square")
                    .resizable()
//                    .bold()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.white)
                    .opacity(1)
                    .blur(radius: 1.5)
                
                Image(systemName: "square")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.black)
            }
        }
        .offset(x: xOffset, y: yOffset)
    }
}

extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
