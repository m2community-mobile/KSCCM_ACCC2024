import UIKit
import AVFoundation

func flash(isOn : Bool) -> Bool? {
    guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return nil}
    
    if (device.hasTorch ) {
        do {
            try device.lockForConfiguration()
            if (isOn) {
                do {
                    try device.setTorchModeOn(level: 1.0)
                    return true
                } catch {
                    print(error)
                }
            } else {
                device.torchMode = AVCaptureDevice.TorchMode.off
                return false
            }
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    return nil
}
