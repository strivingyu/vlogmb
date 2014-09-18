//
//  UMTaskTableViewCell.m
//  vlogmb
//
//  Created by 余少勇 on 14-9-17.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import "UMTaskTableViewCell.h"

@implementation UMTaskTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
