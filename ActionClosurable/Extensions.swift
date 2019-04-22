//
//  Extensions.swift
//  ActionClosurable
//
//  Created by Yoshitaka Seki on 2016/04/11.
//  Copyright © 2016年 Yoshitaka Seki. All rights reserved.
//

import UIKit

public extension Action where Base: UIControl {
    func events(_ controlEvents: UIControl.Event, closure: @escaping (Base) -> Void) {
        base.on(controlEvents, closure: closure)
    }
}

public extension Action where Base: UIButton {
    func tap(_ closure: @escaping (Base) -> Void) {
        base.on(.touchUpInside, closure: closure)
    }
}

public extension Action where Base: UIRefreshControl {
    func valueChanged(closure: @escaping (Base) -> Void) {
        base.on(.valueChanged, closure: closure)
    }
}

public extension Action where Base: UIView {
    func gesture<T: UIGestureRecognizer>(_ type: T.Type, closure: @escaping (T) -> Void) {
        base.addGestureRecognizer(T(closure: closure))
    }
}

public extension Action where Base: UIBarButtonItem {
    func tap(_ closure: @escaping (Base) -> Void) {
        base.convert(closure: closure) {
            base.target = $0
            base.action = $1
        }
    }
}

public extension ActionClosurable where Self: UIRefreshControl {
    init(closure: @escaping (Self) -> Void) {
        self.init()
        on.valueChanged(closure: closure)
    }
}

public extension ActionClosurable where Self: UIGestureRecognizer {
    init(closure: @escaping (Self) -> Void) {
        self.init()
        self.convert(closure: closure) { self.addTarget($0, action: $1) }
    }
}

public extension ActionClosurable where Self: UIBarButtonItem {
    init(title: String, style: UIBarButtonItem.Style, closure: @escaping (Self) -> Void) {
        self.init()
        self.title = title
        self.style = style
        self.on.tap(closure)
    }
    
    init(image: UIImage?, style: UIBarButtonItem.Style, closure: @escaping (Self) -> Void) {
        self.init()
        self.image = image
        self.style = style
        self.on.tap(closure)
    }
    
    init(barButtonSystemItem: UIBarButtonItem.SystemItem, closure: @escaping (Self) -> Void) {
        self.init(barButtonSystemItem: barButtonSystemItem, target: nil, action: nil)
        self.on.tap(closure)
    }
}

private extension ActionClosurable where Self: UIControl {
    func on(_ controlEvents: UIControl.Event, closure: @escaping (Self) -> Void) {
        convert(closure: closure) {
            self.addTarget($0, action: $1, for: controlEvents)
        }
    }
}
