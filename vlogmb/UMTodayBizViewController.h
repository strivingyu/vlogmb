//
//  UMTodayBizViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-4.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMTodayBizViewController : UIViewController
{
    NSString *dateString;
    NSDate *currentDate;
}
@property (weak, nonatomic) IBOutlet UILabel *currentDate;
@property (weak, nonatomic) IBOutlet UILabel *totalOrderNum;
- (IBAction)previousDay:(id)sender;
- (IBAction)nextDay:(id)sender;
-(void) getTotalOrderNumByDate:(NSString *)dateString;
@end
