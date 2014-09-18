//
//  UMAuditAirorderViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-18.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMAuditAirorderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfWorkno;
@property (weak, nonatomic) IBOutlet UITextField *dfShipper;
@property (weak, nonatomic) IBOutlet UITextField *dfDelegateDate;
@property (weak, nonatomic) IBOutlet UITextField *dfSender;
@property (weak, nonatomic) IBOutlet UITextField *dfConsignee;
@property (weak, nonatomic) IBOutlet UITextField *dfNotifyParty;
@property (weak, nonatomic) IBOutlet UITextField *dfGoodsDescription;
@property (weak, nonatomic) IBOutlet UITextField *dfMarks;
@property (weak, nonatomic) IBOutlet UITextField *dfTotalGoodsno;
@property (weak, nonatomic) IBOutlet UITextField *dfTotalWeight;
@property (weak, nonatomic) IBOutlet UITextField *dfVolume;
@property (weak, nonatomic) IBOutlet UITextField *dfDeparturePort;

@property (weak, nonatomic) IBOutlet UITextField *dfDestinationPort;
- (IBAction)pass:(id)sender;
- (IBAction)refuse:(id)sender;
@property (strong, nonatomic) NSString *workno;
@end
