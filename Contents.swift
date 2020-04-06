import UIKit

// KVO - Key-value observing

// KVO is an observer pattern

// NotificationCenter is also an observer pattern

// KVO is a one to many pattern relationship as opposed to delegation which is a one-to-one.

@objc class Dog: NSObject {
    var name: String
    @objc dynamic var age: Int // age is an observable property
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// Observer Class one
class DogWalker {
    let dog: Dog
    var birthdayObservation: NSKeyValueObservation? // a handle for the property being observed i.e. age  property
    
    init(dog: Dog) {
        self.dog = dog
        configBirthdayObservation()
    }
    
    private func configBirthdayObservation() {
        birthdayObservation = dog.observe(\.age, options: [.old,.new], changeHandler: { (dog, change) in
            guard let age = change.newValue else { return }
            print("Hey \(dog.name), happy \(age) birthday from the dog walker")
            print("old value: \(change.oldValue ?? 0)")
            print("new value: \(age)")
        })
    }
}

// Observer Class two
class DogGroomer {
    let dog: Dog
    var birthdayObservation: NSKeyValueObservation?
    
    init(dog: Dog) {
        self.dog = dog
        configBirthdayObservation()
    }
    
    private func configBirthdayObservation() {
        birthdayObservation = dog.observe(\.age, options: [.old,.new], changeHandler: { (dog, change) in
            guard let age = change.newValue else { return }
            print("Hey \(dog.name), happy \(age) birthday from the dog groomer")
            print("old value: \(change.oldValue ?? 0)")
            print("new value: \(age)")
        })
    }
}

let snoopy = Dog(name: "Snoopy", age: 5)

let dogWalker = DogWalker(dog: snoopy)
let dogGroomer = DogWalker(dog: snoopy)

snoopy.age += 1

