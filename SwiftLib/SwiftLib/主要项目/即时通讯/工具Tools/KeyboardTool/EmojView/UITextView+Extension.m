//
//  UITextView+Extension.m
//  SwiftLib
//
//  Created by nb616 on 2017/11/17.
//  Copyright © 2017年 nb616. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
- (BOOL)onTextDeleteisEmo:(BOOL)isEmo block:(void (^)(void))callback {
    NSRange range = [self rangeForPrefix:@"[" suffix:@"]"];
    if (range.length == 1) {
        if (isEmo) {
           [self  deleteBackward];
        }
        return YES;
    }
    [self deleteText:range];
    callback();
    return NO;
    
}
- (NSRange)rangeForPrefix:(NSString *)prefix suffix:(NSString *)suffix
{
    NSString *text = self.text;
    NSRange range = [self selectedRange];
    NSString *selectedText = range.length ? [text substringWithRange:range] : text;
    NSInteger endLocation = range.location;
    if (endLocation <= 0)
    {
        return NSMakeRange(NSNotFound, 0);
    }
    NSInteger index = -1;
    if ([selectedText hasSuffix:suffix]) {
        //往前搜最多20个字符，一般来讲是够了...
        NSInteger p = 20;
        for (NSInteger i = endLocation; i >= endLocation - p && i-1 >= 0 ; i--)
        {
            NSRange subRange = NSMakeRange(i - 1, 1);
            NSString *subString = [text substringWithRange:subRange];
            if ([subString compare:prefix] == NSOrderedSame)
            {
                index = i - 1;
                break;
            }
        }
    }
    return index == -1? NSMakeRange(endLocation - 1, 1) : NSMakeRange(index, endLocation - index);
}
- (void)deleteText:(NSRange)range
{
    NSString *text = self.text;
    if (range.location + range.length <= [text length]
        && range.location != NSNotFound && range.length != 0)
    {
        NSString *newText = [text stringByReplacingCharactersInRange:range withString:@""];
        NSRange newSelectRange = NSMakeRange(range.location, 0);
        [self setText:newText];
        self.selectedRange = newSelectRange;
    }
}
@end
