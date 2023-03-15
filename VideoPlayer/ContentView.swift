import SwiftUI
import AVKit

struct ContentView: View {
    @State private var videoURL: URL?
    
    var body: some View {
        VStack {
            if let videoURL = videoURL {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(width: 400, height: 300)
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
