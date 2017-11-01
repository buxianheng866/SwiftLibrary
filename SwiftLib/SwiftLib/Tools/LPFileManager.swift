//
//  LPFileManager.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/20.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation

let fileMR = FileManager.default
let homePath = NSHomeDirectory()
let urlDocument = fileMR.urls(for: .documentDirectory, in: .userDomainMask)[0]
let urlCache = fileMR.urls(for: .cachesDirectory, in: .userDomainMask)[0]

/** 创建文件夹*/
func createFolder(name: String, baseUrl: URL) -> Bool {
    let folder = baseUrl.appendingPathComponent(name)
    let sucess = fileMR.createFile(atPath: folder.path, contents: nil, attributes: nil)
    return sucess
}


func isExist(atPath: String) -> Bool {
    return fileMR.fileExists(atPath: atPath)
}

func cacheDirectory() -> URL {
    let cachesURL = kApplication.cachesURL
    return cachesURL
}

func dictionaryOfData(_ fileName: String) -> NSMutableDictionary {
    let path = cacheDirectory()
    
    let filePath = path.appendingPathComponent(fileName)
    var dic: NSMutableDictionary?
    
    if let dict = NSMutableDictionary(contentsOf: filePath)  { //从文件加载数据
        dic = dict
    } else {
        dic = NSMutableDictionary()
    }
    return dic!
}

