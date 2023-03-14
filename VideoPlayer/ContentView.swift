import SwiftUI
import AVKit
import AVFoundation

struct VideoPlayerView: NSViewRepresentable {
    let player: AVPlayer
    
    func makeNSView(context: Context) -> NSView {
        let playerView = AVPlayerView()
        playerView.player = player
        return playerView
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}

class AVPlayerView: NSView {
    var player: AVPlayer? {
        didSet {
            (self.layer as? AVPlayerLayer)?.player = player
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.wantsLayer = true
        self.layer = AVPlayerLayer()
        (self.layer as? AVPlayerLayer)?.videoGravity = .resizeAspect
    }
}

struct ContentView: View {
    @State private var player: AVPlayer

    init() {
        let videoURL = Bundle.main.url(forResource: "example", withExtension: "mp4")!
        _player = State(initialValue: AVPlayer(url: videoURL))
    }

    var body: some View {
        VideoPlayerView(player: player)
            .onAppear {
                player.play()
            }
            .onDisappear {
                player.pause()
            }
            .frame(minWidth: 640, minHeight: 480)
            .edgesIgnoringSafeArea(.all)
    }
}

