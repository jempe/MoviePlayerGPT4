import SwiftUI
import SpriteKit

struct WatermarkView: NSViewRepresentable {
    typealias NSViewType = SKView
    
    func makeNSView(context: Context) -> SKView {
        let view = SKView()
        view.allowsTransparency = true
        view.presentScene(makeScene())
        return view
    }
    
    func updateNSView(_ nsView: SKView, context: Context) {}
    
    private func makeScene() -> SKScene {
        let scene = SKScene(size: CGSize(width: 640, height: 480))
        scene.backgroundColor = .clear
        
        let logo = SKSpriteNode(imageNamed: "logo_no_text")
        logo.position = CGPoint(x: scene.size.width - 60, y: 60)
        logo.size = CGSize(width: 120, height: 60)
        logo.alpha = 1
        scene.addChild(logo)
        
        return scene
    }
}
