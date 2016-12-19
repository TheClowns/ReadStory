//
//  AppDelegate.m
//  ReadStory
//
//  Created by 这是C先生 on 2016/12/7.
//  Copyright © 2016年 这是C先生. All rights reserved.
//

#import "AppDelegate.h"
#import "CJLTableViewController.h"
#import "CJLNavigationController.h"
#import "CJLViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    NSData *data = [NSData dataWithContentsOfURL:url];
    
    
    
    NSArray * a = [[NSString stringWithFormat:@"%@",url] componentsSeparatedByString:@"Inbox/"];
    
    NSString * string = [a.lastObject stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    NSString *s = [NSString stringWithFormat:@"%@",url];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [paths objectAtIndex:0];
//    NSString *ss = [docDir stringByAppendingPathComponent:@"1.txt"];
//    [s writeToFile:ss atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    
    NSLog(@"%@",string);
//    data writeToFile:<#(nonnull NSString *)#> atomically:YES];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    CJLTableViewController *ta = [[CJLTableViewController alloc]init];
    
    
    CJLNavigationController *na = [[CJLNavigationController alloc]initWithRootViewController:ta];
    
    self.window.rootViewController = na;
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
#pragma mark -- 存入数据
    
    
//    CJLNavigationController *currentVc =  (CJLNavigationController *)[self getCurrentVC];
     CJLViewController *cjlna = (CJLViewController *)((UINavigationController *)self.window.rootViewController).visibleViewController;
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    
    [user setObject:@(cjlna->selectPageCount) forKey:cjlna.fileName];
    
    [user synchronize];
    
    
    
    
    
    //会调用
    
    
    //失去焦点 进入到多任务
    //将当前的
    
    
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //进入后台   一定走
    NSLog(@"applicationDidEnterBackground");
    
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //得到焦点
    
    NSLog(@"applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    //进入多任务时 会在
    NSLog(@"applicationWillTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
