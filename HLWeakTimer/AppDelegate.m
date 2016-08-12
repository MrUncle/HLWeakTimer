//
//  AppDelegate.m
//  HLWeakTimer
//
//  Created by 刘豪亮 on 13/1/22.
//  Copyright © 2013年 LHL. All rights reserved.
//

#import "AppDelegate.h"
#import "HLSampleViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    HLSampleViewController *vc = [[HLSampleViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
