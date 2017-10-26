//
//  HttpNet.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/19.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
// MARK: - 网络请求

func request(
    _ url: String,
    method: HTTPMethod = .get,
    params: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil)
    -> RequestManager {
    return RequestManager.default.request(url, method: method, params: params, encoding: encoding, headers: headers)
}


// MARK: - 下载
func download(
    _ url: String,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil)
    -> DownloadTaskManager {
    return DownloadManager.default.download(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
}

/** 取消下载*/
func downloadCancel(_ url: String) {
    DownloadManager.default.cancel(url)
}

/** 下载百分比*/
func downloadPercent(_ url: String) -> Double {
    return DownloadManager.default.downloadPercent(url)
}

/** 删除某个下载*/
func downloadDelete(_ url: String) {
    DownloadManager.default.delete(url)
}

/** 下载状态*/
func downloadStatus(_ url: String) -> DownloadStatus {
    return DownloadManager.default.downloadStatus(url)
}

/** 下载完成后，文件所在位置*/
func downloadFilePath(_ url: String) -> URL? {
    return DownloadManager.default.downloadFilePath(url)
}

/** 下载中的进度,任务下载中时，退出当前页面,再次进入时继续下载*/
@discardableResult
func downloadProgress(_ url: String, progress: @escaping ((Double)->())) -> DownloadTaskManager? {
    return DownloadManager.default.downloadProgress(url, progress: progress)
}
