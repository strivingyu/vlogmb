//
//  UMDesignateMonthBizViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-4.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRMonthPicker.h"

@interface UMDesignateMonthBizViewController : UIViewController
{
    NSString *select;
}
@property (weak, nonatomic) IBOutlet SRMonthPicker *selectDateView;
- (IBAction)selectDate:(id)sender;

@end
