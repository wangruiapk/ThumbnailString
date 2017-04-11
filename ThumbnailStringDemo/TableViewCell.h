//
//  TableViewCell.h
//  ThumbnailStringDemo
//
//  Created by wangrui on 2017/4/11.
//  Copyright © 2017 wangrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

- (void)configWithBodyString:(NSString *)bodyString
                  tailString:(NSString *)tailString
                   indexPath:(NSIndexPath *)indexPath;

@end
