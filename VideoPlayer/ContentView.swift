import SwiftUI
import AVKit

struct ContentView: View {
    @State private var videoURL: URL?
    @State private var isPlaying = false
    @State private var playbackTime: CMTime = .zero
    @State private var duration: CMTime = .zero
    
    var body: some View {
        VStack {
            if let videoURL = videoURL {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(width: 400, height: 300)
                    .onAppear {
                        let player = AVPlayer(url: videoURL)
                        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: .main) { time in
                            playbackTime = time
                            duration = player.currentItem?.duration ?? .zero
                        }
                        player.play()
                        isPlaying = true
                    }
                    .onDisappear {
                        let player = AVPlayer(url: videoURL)
                        player.pause()
                        isPlaying = false
                    }
                
                HStack {
                    Button(action: {
                        isPlaying ? AVPlayer(url: videoURL).pause() : AVPlayer(url: videoURL).play()
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                            .font(.title)
                    }
                    
                    Slider(value: Binding(
                        get: {
                            playbackTime.seconds / duration.seconds
                        },
                        set: { newValue in
                            let newTime = CMTime(seconds: Double(newValue) * duration.seconds, preferredTimescale: 1000)
                            AVPlayer(url: videoURL).seek(to: newTime)
                        }
                    ))
                    
                    Text(duration.stringFromTimeInterval())
                }
                .padding(.horizontal)
            } else {
                Text("Please select a video file")
            }
            
            Button("Select Video File") {
                let openPanel = NSOpenPanel()
                openPanel.allowedFileTypes = ["mp4"] // add more file types as needed
                openPanel.canChooseFiles = true
                openPanel.canChooseDirectories = false
                openPanel.allowsMultipleSelection = false
                
                if openPanel.runModal() == .OK {
                    videoURL = openPanel.url
                }
            }
        }
    }
}

extension CMTime {
    func stringFromTimeInterval() -> String {
        let totalSeconds = Int(self.seconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }
}
