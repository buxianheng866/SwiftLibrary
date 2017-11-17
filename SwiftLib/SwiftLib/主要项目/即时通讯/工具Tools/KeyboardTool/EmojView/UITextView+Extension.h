//
//  UITextView+Extension.h
//  SwiftLib
//
//  Created by nb616 on 2017/11/17.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (BOOL)onTextDeleteisEmo:(BOOL)isEmo block:(void(^)(void))callback;
- (NSRange)rangeForPrefix:(NSString *)prefix suffix:(NSString *)suffix;
@end
