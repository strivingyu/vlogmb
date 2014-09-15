//
//  UMCurrentYearBizViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-4.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNLineChartView.h"

@interface UMCurrentYearBizViewController : UIViewController
{
    NSDate *currentDate;
}
@property(nonatomic,strong)NSString *dateString;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
@property (weak, nonatomic) IBOutlet UILabel *totalOrderNum;
@property (weak, nonatomic) IBOutlet PNLineChartView *lineChartView;
- (IBAction)previousYear:(id)sender;
- (IBAction)nextYear:(id)sender;

@end
