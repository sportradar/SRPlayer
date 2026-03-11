//
//  StreamSource.swift
//  SRAVPlayerDemo
//
//  Created by Andreas Becher on 10.12.25.
//


//MARK: - Stream Samples
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
            return "https://lc-live-ll-hls.akamaized.net/24770/7745431/mobile-ireland/master_ll.m3u8?cid=24770&mid=66996414&ecid=7745431&pid=2&dtid=1&sid=771189274773&gc=hts&gsd=9A&grm=1&hdnts=ip=2a04:9546:2e1f:3601:b0f1:6836:ef59:e5dc~exp=1766489888~acl=/24770/7745431/mobile-ireland/*~hmac=e415d40701b00e56cd9686ddee475b955f42601f5c1a8c7ffc7f51dea6ee1d2f"
        }
    }
}
