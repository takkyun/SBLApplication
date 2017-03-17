//
//  SBLApplication.swift
//  SBLApplication
//
//  Created by Takuya Otani on 17/03/17.
//  Copyright (c) 2017 Takuya Otani / SerendipityNZ Ltd.
//

import UIKit

open class SBLApplication: UIApplication {

  /// Get an application version as "SHORT (BUILD)" format
  open class var appVersion: String {
    let short = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    let build = Bundle.main.infoDictionary?["CFBundleVersion"]
    if short != nil && build != nil {
      return "\(short!) (\(build!))"
    }
    if short != nil {
      return "\(short!) (-)"
    }
    if build != nil {
      return "- (\(build!))"
    }
    return "- (-)"
  }

  /// A shortcut to get display name of app
  open class var displayName: String {
    if let localizedName = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String {
      return localizedName
    }
    if let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
      return bundleName
    }
    return ""
  }

  /// Show a touch indicators
  open var isShowingTouchIndicators: Bool = false

  fileprivate var touchIndicators: Set<UIView> = []
}

extension SBLApplication {

  private var newIndicator: UIView {
    let indicator = UIView(frame: CGRect(x:0, y:0, width:40, height:40))
    indicator.alpha = 0.5
    indicator.backgroundColor = .white
    indicator.layer.borderColor = UIColor.darkGray.cgColor
    indicator.layer.borderWidth = 1
    indicator.layer.cornerRadius = 20
    return indicator
  }

  private func setupTouchindicators(upto count: Int) {
    if count > 0 {
      for _ in 0 ..< count {
        touchIndicators.insert(newIndicator)
      }
    }
    else if count < 0 {
      for _ in 0 ..< abs(count) {
        let indicator = touchIndicators.first
        indicator!.removeFromSuperview()
        touchIndicators.removeFirst()
      }
    }
  }

  private func flashIndicator(_ indicator: UIView) {
    let animation = {
      indicator.transform = CGAffineTransform(scaleX: 2, y: 2)
      indicator.alpha = 0
    }
    UIView.animate(withDuration: 0.2,
                   delay: 0,
                   options: [.curveEaseInOut,.allowUserInteraction],
                   animations: animation) { (finish) in
      indicator.removeFromSuperview()
    }
  }

  private func updateTouchIndicators(_ touches: Set<UITouch>?) {
    let touchCount = (touches ?? []).count
    setupTouchindicators(upto: touchCount - touchIndicators.count)
    assert(touchIndicators.count == touchCount)

    guard let touches = touches else {
      return
    }
    let window = windows.last
    var toBeRemoved: Set<UIView> = []
    var index = touchIndicators.startIndex
    for touch in touches {
      let indicator = touchIndicators[index]
      if touch.phase == .ended {
        flashIndicator(indicator)
        toBeRemoved.insert(indicator)
      }
      else if touch.phase == .cancelled {
        indicator.removeFromSuperview()
        toBeRemoved.insert(indicator)
      }
      else {
        var rect = indicator.frame
        rect.origin = touch.location(in: window!)
        rect.origin.x -= rect.width / 2
        rect.origin.y -= rect.height / 2
        indicator.frame = rect
        window!.addSubview(indicator)
        if touch.phase == .began {
          let effect = newIndicator
          effect.frame = indicator.bounds
          indicator.addSubview(effect)
          flashIndicator(effect)
        }
      }
      index = touchIndicators.index(after: index)
    }
    for removed in toBeRemoved {
      touchIndicators.remove(removed)
    }
  }

  override open func sendEvent(_ event: UIEvent) {
    if event.type == .touches {
      updateTouchIndicators(isShowingTouchIndicators ? event.allTouches : nil)
    }
    super.sendEvent(event)
  }
}
