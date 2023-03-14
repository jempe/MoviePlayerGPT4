import SwiftUI
import AVKit
import AVFoundation
import AppKit

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
    @State private var player: AVPlayer?

    var body: some View {
        VStack {
            if let player = player {
                VideoPlayerViewController(player: player)
                    .frame(minWidth: 640, minHeight: 480)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("No video selected.")
                    .frame(minWidth: 640, minHeight: 480)
            }

            Button("Select Video") {
                openVideoFile()
            }
            .padding()
        }
    }

    private func openVideoFile() {
        let panel = NSOpenPanel()
        panel.allowedFileTypes = ["mp4", "mov", "m4v", "avi"] // Add more video file types as needed
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true

        if panel.runModal() == .OK {
            if let url = panel.url {
                player = AVPlayer(url: url)
            }
        }
    }
}
