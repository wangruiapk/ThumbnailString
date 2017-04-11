//
//  ThumbnailStringHelper.m
//  ThumbnailStringDemo
//
//  Created by wangrui on 2017/4/11.
//  Copyright © 2017 wangrui. All rights reserved.
//

#import "ThumbnailStringHelper.h"
#import "NSAttributedString+Helper.h"

@implementation ThumbnailStringHelper

+ (NSAttributedString *)thumbnailAttributedStringWithBodyString:(NSString *)bodyString
                                                     tailString:(NSString *)tailString
                                                       bodyFont:(UIFont *)bodyFont
                                                       tailFont:(UIFont *)tailFont
                                                  bodyTextColor:(UIColor *)bodyTextColor
                                                  tailTextColor:(UIColor *)tailTextColor
                                               constrainedWidth:(CGFloat)constrainedWidth
                                              limitedLineNumber:(NSInteger)limitedLineNumber
                                               autoLinefeedTail:(BOOL)autoLinefeedTail
                                            firstLineHeadIndent:(CGFloat)firstLineHeadIndent
{
    NSAttributedString *attributedString = [ThumbnailStringHelper attributedStringWithBodyString:bodyString
                                                                                tailString:tailString
                                                                                  bodyFont:bodyFont
                                                                                  tailFont:tailFont
                                                                             bodyTextColor:bodyTextColor
                                                                             tailTextColor:tailTextColor
                                                                       firstLineHeadIndent:firstLineHeadIndent];
    NSArray *linesArray = [attributedString linesArrayWithConstrainedWidth:constrainedWidth
                                                       firstLineHeadIndent:firstLineHeadIndent];
    NSInteger linesCount = linesArray.count;
    NSRange lastRange = [[linesArray lastObject] rangeValue];
    if (limitedLineNumber == 0) {
        if (autoLinefeedTail) {
            if (lastRange.length < tailString.length) {
                NSString *newTailString = [@"\n" stringByAppendingString:tailString];
                attributedString = [ThumbnailStringHelper attributedStringWithBodyString:bodyString
                                                                        tailString:newTailString
                                                                          bodyFont:bodyFont
                                                                          tailFont:tailFont
                                                                     bodyTextColor:bodyTextColor
                                                                     tailTextColor:tailTextColor
                                                               firstLineHeadIndent:firstLineHeadIndent];
            }
        }
    }
    else {
        if (linesCount <= limitedLineNumber) {
            if (autoLinefeedTail) {
                if (lastRange.length < tailString.length) {
                    NSString *newTailString = [@"\n" stringByAppendingString:tailString];
                    attributedString = [ThumbnailStringHelper attributedStringWithBodyString:bodyString
                                                                            tailString:newTailString
                                                                              bodyFont:bodyFont
                                                                              tailFont:tailFont
                                                                         bodyTextColor:bodyTextColor
                                                                         tailTextColor:tailTextColor
                                                                   firstLineHeadIndent:firstLineHeadIndent];
                }
            }
        }
        else {
            NSRange limitedLineRange = [linesArray[limitedLineNumber] rangeValue];
            CGFloat replaceLocation = 0;
            CGFloat replaceLength = 0;
            if (limitedLineRange.location > bodyString.length) {
                replaceLength = limitedLineRange.length+3;
                replaceLocation = bodyString.length-replaceLength;
            }
            else {
                replaceLocation = limitedLineRange.location-3-tailString.length;
                replaceLength = tailString.length+3;
            }
            NSString *newBodyString = [bodyString substringToIndex:replaceLocation];
            newBodyString = [newBodyString stringByAppendingString:@"..."];
            attributedString = [ThumbnailStringHelper attributedStringWithBodyString:newBodyString
                                                                    tailString:tailString
                                                                      bodyFont:bodyFont
                                                                      tailFont:tailFont
                                                                 bodyTextColor:bodyTextColor
                                                                 tailTextColor:tailTextColor
                                                           firstLineHeadIndent:firstLineHeadIndent];
        }
    }
    return attributedString;
}

+ (NSAttributedString *)attributedStringWithBodyString:(NSString *)bodyString
                                            tailString:(NSString *)tailString
                                              bodyFont:(UIFont *)bodyFont
                                              tailFont:(UIFont *)tailFont
                                         bodyTextColor:(UIColor *)bodyTextColor
                                         tailTextColor:(UIColor *)tailTextColor
                                   firstLineHeadIndent:(CGFloat)firstLineHeadIndent
{
    NSString *contentString = [bodyString stringByAppendingString:tailString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:contentString];
    NSRange bodyRange = [contentString rangeOfString:bodyString];
    NSRange tailRange = [contentString rangeOfString:tailString];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:bodyTextColor
                             range:bodyRange];
    [attributedString addAttribute:NSFontAttributeName
                             value:bodyFont
                             range:bodyRange];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:tailTextColor
                             range:tailRange];
    [attributedString addAttribute:NSFontAttributeName
                             value:tailFont
                             range:tailRange];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, contentString.length)];
    return attributedString;
}

@end
