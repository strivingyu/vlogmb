//
//  UMTaskTableViewController.h
//  vlogmb
//
//  Created by 余少勇 on 14-9-17.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMTaskTableViewController : UITableViewController
@property(nonatomic,retain) NSArray *taskList;
@property (strong, nonatomic) NSString *workno;
@property (strong, nonatomic) NSNumber *denominated;
@property (strong, nonatomic) NSString *memo;
@end
