import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "example", withExtension: "mp4")!))
            .frame(width: 400, height: 300)
    }
}
