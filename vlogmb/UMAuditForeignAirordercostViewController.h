//
//  UMAuditForeignAirordercostViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-18.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASFTableView.h"
@interface UMAuditForeignAirordercostViewController : UIViewController
@property (weak, nonatomic) IBOutlet ASFTableView *mASFTableView;

- (IBAction)pass:(id)sender;
- (IBAction)refuse:(id)sender;
@property (strong, nonatomic) NSString *workno;
@property (strong, nonatomic) NSNumber *denominated;
@property (strong, nonatomic) NSString *memo;
@property (strong, nonatomic) NSString *serialno;
@end
