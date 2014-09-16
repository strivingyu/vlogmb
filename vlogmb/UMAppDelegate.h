//
//  UMAppDelegate.h
//  vlogmb
//
//  Created by 余少勇 on 14-8-24.
//  Copyright (c) 2014年 you-meng.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UMAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSNumber *branchcompanyid;
@property (strong, nonatomic) NSString *username;
+(NSString *) basePath;
@end
