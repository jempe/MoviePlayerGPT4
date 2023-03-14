import SwiftUI
import AVKit

struct VideoPlayerViewController: NSViewControllerRepresentable {
    let player: AVPlayer

    func makeNSViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsSharingServiceButton = false
        return controller
    }

    func updateNSViewController(_ nsViewController: AVPlayerViewController, context: Context) {}
}
