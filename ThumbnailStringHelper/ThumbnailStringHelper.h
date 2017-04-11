//
//  ThumbnailStringHelper.h
//  ThumbnailStringDemo
//
//  Created by wangrui on 2017/4/11.
//  Copyright © 2017 wangrui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThumbnailStringHelper : NSObject

+ (NSAttributedString *)thumbnailAttributedStringWithBodyString:(NSString *)bodyString
                                                     tailString:(NSString *)tailString
                                                       bodyFont:(UIFont *)bodyFont
                                                       tailFont:(UIFont *)tailFont
                                                  bodyTextColor:(UIColor *)bodyTextColor
                                                  tailTextColor:(UIColor *)tailTextColor
                                               constrainedWidth:(CGFloat)constrainedWidth
                                              limitedLineNumber:(NSInteger)limitedLineNumber
                                               autoLinefeedTail:(BOOL)autoLinefeedTail
                                            firstLineHeadIndent:(CGFloat)firstLineHeadIndent;

@end
