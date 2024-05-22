//
//  ContentView.swift
//  Visionyes
//
//  Created by Michael Potter on 1/31/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State var cookies: Int = 0
    @State var cps: Int = 0
    @State var models: [Int] = []
    @State var manualClick: Int = 1
    @State var ClickUpgrade1Cost: Double = 25.0
    @State var ClickUpgrade2Cost: Double = 250.0
    @State var upgrade1cost: Double = 50.0
    @State var upgrade2cost: Double = 500.0
    @State var check: Bool = false
    @State var particles = ParticleEmitterComponent()
    
    var body: some View {
        HStack{
            VStack{
                
                Button(action: {
                    manualClick += 1
                    cookies -= Int(ClickUpgrade1Cost)
                    ClickUpgrade1Cost *= 1.15
                }, label: {
                    Text("Clicking Upgrade\nCost: \(Int(ClickUpgrade1Cost))").minimumScaleFactor(0.1)
                }).disabled(cookies >= Int(ClickUpgrade1Cost) ? false : true)
                Button(action: {
                    manualClick += 15
                    cookies -= Int(ClickUpgrade2Cost)
                    ClickUpgrade2Cost *= 1.15
                }, label: {
                    Text("Clicking Upgrade 2\nCost: \(Int(ClickUpgrade2Cost))").minimumScaleFactor(0.1)
                }).disabled(cookies >= Int(ClickUpgrade2Cost) ? false : true)
                
            }.frame(width:150)
            VStack{
                Spacer()
                Button(action: {
                    models = []
                    cookies = 0
                    cps = 0
                    manualClick = 1
                    ClickUpgrade1Cost = 25.0
                    upgrade1cost = 50.0
                    upgrade2cost = 500.0
                }, label: {
                    Text("Reset")
                })
                Button(action: {
                    cps += 1
                }, label: {
                    Text("+cps")
                })
                Text("Cookies per second: \(cps)")
                Text("Manual click power: \(manualClick)")
                Spacer()
                Text("Cookies:")
                
                HStack
                {
                    
                    ForEach(0..<numbers(cookies).count, id: \.self)  { i in
                        ZStack {
                            Model3D(named: "0",bundle: realityKitContentBundle)
                                .opacity(numbers(cookies)[i] == 0 ? 1.0 : 0.0)
                                .offset(z: 0)
                            
                            Model3D(named: "1",bundle: realityKitContentBundle)
                                .opacity(numbers(cookies)[i] == 1 ? 1.0 : 0.0)
                                .offset(z: -25)
                            Model3D(named: "2",bundle: realityKitContentBundle)
                                .opacity(numbers(cookies)[i] == 2 ? 1.0 : 0.0)
                                .offset(z:-55)
                            Model3D(named: "3",bundle: realityKitContentBundle)
                                .opacity(numbers(cookies)[i] == 3 ? 1.0 : 0.0)
                                .offset(z:-85)
                            Model3D(named: "4",bundle: realityKitContentBundle)
                                .opacity(numbers(cookies)[i] == 4 ? 1.0 : 0.0)
                                .offset(z:-110)
                            Model3D(named: "5",bundle: realityKitContentBundle)
                                .opacity(numbers(cookies)[i] == 5 ? 1.0 : 0.0)
                                .offset(z:-135)
                            Model3D(named: "6",bundle: realityKitContentBundle)
                                .opacity(numbers(cookies)[i] == 6 ? 1.0 : 0.0)
                                .offset(z:-160)
                            Model3D(named: "7",bundle: realityKitContentBundle)
                                .opacity(numbers(cookies)[i] == 7 ? 1.0 : 0.0)
                                .offset(z:-190)
                            Model3D(named: "8",bundle: realityKitContentBundle)
                                .opacity(numbers(cookies)[i] == 8 ? 1.0 : 0.0)
                                .offset(z:-220)
                            Model3D(named: "9",bundle: realityKitContentBundle)
                                .opacity(numbers(cookies)[i] == 9 ? 1.0 : 0.0)
                                .offset(z:-245)
                        }.minimumScaleFactor(0.1)
                        //                    Model3D(named: "\(numbers(cookies)[i])",bundle: realityKitContentBundle)
                    }
                    
                    
                }.minimumScaleFactor(0.1)
                
                ZStack{
                    
                    Button(action: {
                        cookies += manualClick
                        check.toggle()
//                        particles.mainEmitter.birthRate = 10.0
//                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
//                            check.toggle()
//                            particles.mainEmitter.birthRate = 0.0
//                        }
                    }, label: {
                        Model3D(named: "Cookie", bundle: realityKitContentBundle)
                            .frame(depth: 100)
                    })
//                    Text("x")
//                    RealityView { content in
//                        let model = ModelEntity()
//                        model.components.set(ParticleEmitterComponent())
//                    }
//                    
//                    
//                    RealityView { content in
//                        let model = ModelEntity()
//                        model.components.set(particles)
//                        content.add(model)
//                    }
//                    .offset(z: -200)
                    
                    
                }
                
            }.frame(width: 400)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { time in
                        cookies += cps
                        
                    }
                }
            VStack{
                Button(action: {
                    cps += 1
                    cookies -= Int(upgrade1cost)
                    upgrade1cost *= 1.25
                }, label: {
                    Text("Upgrade 1\nCost: \(Int(upgrade1cost))")
                        .minimumScaleFactor(0.1)
                }).disabled(cookies >= Int(upgrade1cost) ? false : true)
                
                Button(action: {
                    cps += 25
                    cookies -= Int(upgrade2cost)
                    upgrade2cost *= 1.25
                }, label: {
                    Text("Upgrade 2\nCost: \(Int(upgrade2cost))")
                        .minimumScaleFactor(0.1)
                })
                .disabled(cookies >= Int(upgrade2cost) ? false : true)
                
                
                
            }.frame(width:150)
        }.onAppear{
            particles.emitterShape = .plane
            particles.emitterShapeSize = [1,1,1] * 0.05
            
            particles.mainEmitter.birthRate = 0.0
            
            particles.mainEmitter.size = 0.10
            particles.mainEmitter.lifeSpan = 0.5
            particles.mainEmitter.color = .evolving(start: .single(.white), end: .single(.white))
            particles.mainEmitter.angleVariation = Float.pi
            particles.mainEmitter.billboardMode = .billboard
        }
    }
    
    func numbers(_ cookies: Int) -> [Int] {
        let arr2 = String(cookies).utf8.map{Int($0)-48}
        //        print(cookies)
        //        print(arr2)
        return arr2
    }
    
    
    func particleSystem() -> ParticleEmitterComponent {
        var particles = ParticleEmitterComponent()
        particles.emitterShape = .plane
        particles.emitterShapeSize = [1,1,1] * 0.05
        
        particles.mainEmitter.birthRate = 1.0
        particles.mainEmitter.size = 0.05
        particles.mainEmitter.lifeSpan = 0.5
        particles.mainEmitter.color = .evolving(start: .single(.white), end: .single(.white))
        return particles
    }
    
}

//#Preview(windowStyle: .automatic) {
//    ContentView(array: RealityViewEntityCollection.first(RealityViewEntityCollection))
//}
