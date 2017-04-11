//
//  TableViewCell.m
//  ThumbnailStringDemo
//
//  Created by wangrui on 2017/4/11.
//  Copyright © 2017 wangrui. All rights reserved.
//

#import "TableViewCell.h"
#import "ThumbnailStringHelper.h"

@interface TableViewCell ()
{
    CGFloat cellWidth;
    CGFloat cellHeight;
}

@property (nonatomic, strong) UILabel *cellLabel;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    cellWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    cellHeight = 80;
    self.cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, cellWidth-30, cellHeight)];
    [self.contentView addSubview:self.cellLabel];
}

- (void)configWithBodyString:(NSString *)bodyString
                  tailString:(NSString *)tailString
                   indexPath:(NSIndexPath *)indexPath
{
    NSInteger limitedLineNumber = indexPath.row%5;
    NSAttributedString *attributedString = [ThumbnailStringHelper thumbnailAttributedStringWithBodyString:bodyString
                                                                                         tailString:tailString
                                                                                           bodyFont:[UIFont systemFontOfSize:16]
                                                                                           tailFont:[UIFont italicSystemFontOfSize:16]
                                                                                      bodyTextColor:[UIColor darkGrayColor]
                                                                                      tailTextColor:[UIColor redColor]
                                                                                   constrainedWidth:cellWidth-30
                                                                                  limitedLineNumber:limitedLineNumber
                                                                                   autoLinefeedTail:NO
                                                                                firstLineHeadIndent:0];
    self.cellLabel.attributedText = attributedString;
    self.cellLabel.numberOfLines = limitedLineNumber;
}

@end
