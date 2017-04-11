//
//  NSAttributedString+Helper.h
//  ThumbnailStringDemo
//
//  Created by wangrui on 2017/4/11.
//  Copyright © 2017 wangrui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface NSAttributedString (Helper)

- (NSArray *)linesArrayWithConstrainedWidth:(CGFloat)constrainedWidth
                        firstLineHeadIndent:(CGFloat)firstLineHeadIndent;
- (CGFloat)singleLineHeight;

@end
