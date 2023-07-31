import ARKit

class EyeViewController: NSObject, ObservableObject {
    @Published var eyeMyViewModel = EyeMyViewModel()

    var session = ARSession()

    override init() {
//        AR 트래킹 사용 가능한지 확인하는 부분인데, xcode에서 크래시가 나서 일단 주석처리
//        guard ARFaceTrackingConfiguration.isSupported,
//                       ARFaceTrackingConfiguration.supportsWorldTracking else {
//                   // In reality you would want to fall back to another AR experience or present an error
//                   fatalError("I can't do face things with world things which is kind of the point")
//               }
        super.init()
        let configuration = ARFaceTrackingConfiguration()
        session.run(configuration)
        session.delegate = self
    }

    //TODO: 제대로 작동하는지 확인할 것
    func resetFaceAnchor() {
        session.pause()
        for anchor in session.currentFrame?.anchors ?? [] {
            session.remove(anchor: anchor)
        }
        session.run(ARFaceTrackingConfiguration())
    }
}

extension EyeViewController: ARSessionDelegate {
    func session(_: ARSession, didUpdate anchors: [ARAnchor]) {
        if let faceAnchor = anchors.first as? ARFaceAnchor {
            eyeMyViewModel.update(faceAnchor: faceAnchor)
        }
    }
}
