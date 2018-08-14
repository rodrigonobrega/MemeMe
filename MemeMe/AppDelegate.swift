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
    private var memes:[Meme] = [Meme]()
    private let kMemesKey = "memes"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // check if exist meme in user defaults
        if let memesDecoded = UserDefaults.standard.object(forKey: kMemesKey) as? NSData {
            if let memesUserDefaults = NSKeyedUnarchiver.unarchiveObject(with: memesDecoded as Data) as? [Meme] {
                memes = memesUserDefaults
            }
        }
        return true
    }

    func save(meme: Meme) {
        self.memes.append(meme)
        saveMemeInUserDefaults()
    }
    
    // MARK: - Use UserDefaults to simulate a database
    func saveMemeInUserDefaults(){
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: memes)
        UserDefaults.standard.set(encodedData, forKey: kMemesKey)
        UserDefaults.standard.synchronize()
    }
    
    static func memes() -> [Meme] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
}

