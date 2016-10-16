//
//  ImageStore.swift
//  CommunityApp
//
//  Created by Dan Esrey on 2016/16/10.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class ImageStore {
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    func imageURLForKey(_ key:String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
    func setImage() {
        
    }
    
    func imageForKey() {
        
    }
    
    func deleteImageForKey() {
        
    }
    
}
