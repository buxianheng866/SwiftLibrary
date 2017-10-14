//
//  LPPhotoHelper.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/13.
//  Copyright © 2017年 nb616. All rights reserved.
//

import UIKit
import MobileCoreServices
typealias photoHelperBlock = (_ data: Any?) -> Void

class LPPhotoHelper: UIImagePickerController {
    lazy var helper = photoDelegateHelper()
    
    class func open(_ sourceType: UIImagePickerControllerSourceType) -> LPPhotoHelper {
        let picker = LPPhotoHelper()
        picker.delegate = picker.helper
        picker.sourceType = sourceType
        return picker
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barStyle = .black
        navigationBar.barTintColor = kNavBarColor
        
    }
}

extension LPPhotoHelper {
    func showSelectedImage(photoHelper block: @escaping photoHelperBlock) -> Void {
        self.helper.selectedImageBlock = block
        kApplication.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
    }
}

class photoDelegateHelper: NSObject{
    var selectedImageBlock: photoHelperBlock?
    deinit {
        print("销毁了")
    }
}

extension photoDelegateHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let mediaType = info["UIImagePickerControllerMediaType"] as? String else {
            return
        }
        
        if mediaType == String(kUTTypeImage) {
            var theImage: UIImage? = nil
            if picker.allowsEditing {
                theImage = info["UIImagePickerControllerEditedImage"] as? UIImage
            } else {
                theImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
            }
             selectedImageBlock?(theImage)
        } else {
            let mediaURL = info["UIImagePickerControllerMediaURL"] as? URL
            // 回调
            selectedImageBlock?(mediaURL)
        }

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
