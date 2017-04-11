//
//  NSAttributedString+Helper.m
//  ThumbnailStringDemo
//
//  Created by wangrui on 2017/4/11.
//  Copyright © 2017 wangrui. All rights reserved.
//

#import "NSAttributedString+Helper.h"

@implementation NSAttributedString (Helper)

- (NSArray *)linesArrayWithConstrainedWidth:(CGFloat)constrainedWidth
                        firstLineHeadIndent:(CGFloat)firstLineHeadIndent
{
    NSAttributedString *attributedString = self;
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,constrainedWidth,999));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        [linesArray addObject:[NSValue valueWithRange:range]];
    }
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return linesArray;
}

- (CGFloat)singleLineHeight
{
    CGFloat lineHeight = 0;
    NSAttributedString *attributedString = self;
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,999,999));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    if ([lines count] > 0) {
        id line = [lines firstObject];
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CGRect lineRect = CTLineGetBoundsWithOptions(lineRef, kCTLineBoundsExcludeTypographicLeading);
        lineHeight = lineRect.size.height;
    }
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return lineHeight;
}

@end
