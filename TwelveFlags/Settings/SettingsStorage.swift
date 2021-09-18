//
//  SettingsStorage.swift
//  TwelveFlags
//
//  Created by RnD on 9/17/21.
//

import Foundation
import Combine

@propertyWrapper
final class SettingsStorage<T>: NSObject {
    // The wrapped value is stored in user defaults
    var wrappedValue: T {
        get {
            return userDefaults.object(forKey: key) as! T
        }
        set {
            userDefaults.setValue(newValue, forKey: key)
        }
    }
    var projectedValue: AnyPublisher<T, Never> {
        return subject.eraseToAnyPublisher()
    }

    private let key: String
    private let userDefaults: UserDefaults
    private var observerContext = 0
    private let subject: CurrentValueSubject<T, Never>

    init(wrappedValue defaultValue: T, _ key: String, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.userDefaults = userDefaults
        self.subject = CurrentValueSubject(defaultValue)
        super.init()
        userDefaults.register(defaults: [key: defaultValue])
        // The publisher is only called when the value is updated, not when any value stored in UserDefaults is updated
        userDefaults.addObserver(self, forKeyPath: key, options: .new, context: &observerContext)
        subject.value = wrappedValue
    }

    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {
        if context == &observerContext {
            subject.value = wrappedValue
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    deinit {
        userDefaults.removeObserver(self, forKeyPath: key, context: &observerContext)
    }
}
