//
//  SharePlatformViewFactory.swift
//  flutter_to_airplay
//
//  Created by Junaid Rehmat on 22/08/2020.
//

import Foundation
import Flutter

class SharePlatformViewFactory: NSObject, FlutterPlatformViewFactory {
    let _messenger : FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger & NSObjectProtocol) {
        _messenger = messenger
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let arguments = args as! Dictionary<String, Any>;
        if let viewClass = arguments["class"] {
            let vc = viewClass as! String
            if vc == "AirplayRoutePicker" {
                let pickerView = FlutterRoutePickerView(messenger: _messenger, viewId: viewId, arguments: arguments)
                return pickerView
            }
            else if vc == "FlutterAVPlayerView" {
                let pickerView = FlutterAVPlayer(frame: frame, viewIdentifier: viewId, arguments: arguments, binaryMessenger: _messenger)
                return pickerView
            }
        }

        return UIView() as! FlutterPlatformView
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
