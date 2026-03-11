//
//  StreamSource.swift
//  SRAVPlayerAppleTVDemo
//
//  Created by Boris Filipovic on 22. 12. 25.
//

// MARK: - Stream Samples.
enum StreamSource: String, CaseIterable, Identifiable {
    case elephantsDream
    case elephantsDream2
    case tearsOfSteel
    case tearsOfSteel2
    case invalid
    case customStream
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .elephantsDream: return "Elephants Dream"
        case .elephantsDream2: return "Elephants Dream 2"
        case .tearsOfSteel:   return "Tears of Steel"
        case .tearsOfSteel2:  return "Tears of Steel 2"
        case .invalid:        return "Invalid Stream"
        case .customStream:   return "custom stream"
        }
    }
    
    var url: String {
        switch self {
        case .elephantsDream:
            return "https://cdn.theoplayer.com/video/elephants-dream/playlist.m3u8"
        case .elephantsDream2:
            return "https://d2zihajmogu5jn.cloudfront.net/elephantsdream/hls/ed_hd.m3u8"
        case .tearsOfSteel:
            return "https://bitmovin-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
        case .tearsOfSteel2:
            return "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"
        case .invalid:
            return "https://invalid.url/playlist.m3u8"
        case .customStream:
            return "https://d1iwufdzc9krup.cloudfront.net/7626265/mobile-ireland/pybKoCjyAdcN_NlH5FzsFfP2Tg0p09lx5Rxiuz7E7Rs/cid=24770~mid=66350470~ecid=7626265~pid=2~dtid=1~sid=515184073539~gc=8aM~gsd=gw~grm=1~e=1765466623~ip=2a04%3A9546%3A2e1f%3A3601%3Ae45c%3A5a35%3A4e8b%3Aec9f/master.m3u8"
        }
    }
}
