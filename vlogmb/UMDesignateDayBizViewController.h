//
//  UMDesignateDayBizViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-4.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMDesignateDayBizViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *totalOrderNum;
- (IBAction)getTotalOrderNum:(id)sender;
-(void) getTotalOrderNumByDate:(NSString *)dateString;
@end
