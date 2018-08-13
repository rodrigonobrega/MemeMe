//
//  AppDelegate.swift
//  MemeMe
//
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes:[Meme] = [Meme]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let memesDecoded = UserDefaults.standard.object(forKey: "memes") as? NSData {
            if let memesUserDefaults = NSKeyedUnarchiver.unarchiveObject(with: memesDecoded as Data) as? [Meme] {
                memes = memesUserDefaults
            }
        }
        return true
    }

    func save(meme: Meme) {
        self.memes.append(meme)
        saveUserDefaults()
    }
    func saveUserDefaults(){
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: memes)
        UserDefaults.standard.set(encodedData, forKey: "memes")
        
        
        UserDefaults.standard.synchronize()
    }
}

