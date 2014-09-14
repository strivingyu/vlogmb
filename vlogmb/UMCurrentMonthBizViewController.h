//
//  UMCurrentMonthBizViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-4.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMCurrentMonthBizViewController : UIViewController
{
    NSString *dateString;
    NSDate *currentDate;
}
@property (weak, nonatomic) IBOutlet UILabel *month;

@property (weak, nonatomic) IBOutlet UILabel *totalOrderNum;
- (IBAction)previousMonth:(id)sender;
- (IBAction)nextMonth:(id)sender;
-(void) getTotalOrderNumByMonth:(NSString *)dateString;
-(void) listAirorderNumByMonth:(NSString *)dateString;
@end
