import Combine
import AVFoundation

class VideoPlayerViewModel: ObservableObject {
    @Published var player: AVPlayer?
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var isPlaying: Bool = false

    private var timeObserver: Any?
    private var cancellables = Set<AnyCancellable>()

    init() {
        $player
            .sink { [weak self] player in
                self?.configureTimeObserver(for: player)
                self?.updateDuration(for: player)
            }
            .store(in: &cancellables)
    }

    private func configureTimeObserver(for player: AVPlayer?) {
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
            timeObserver = nil
        }

        timeObserver = player?.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 1),
            queue: .main
        ) { [weak self] _ in
            guard let self = self, let player = self.player else { return }
            self.currentTime = player.currentTime().seconds
        }
    }

    private func updateDuration(for player: AVPlayer?) {
        if let duration = player?.currentItem?.asset.duration {
            self.duration = duration.seconds
        } else {
            self.duration = 0
        }
    }

    deinit {
        if let observer = timeObserver, let player = player {
            player.removeTimeObserver(observer)
        }
    }
}
