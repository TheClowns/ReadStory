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
@property (nonatomic,strong) NSUserDefaults * user;
@end

@implementation AppDelegate

- (NSUserDefaults *)user{
    if (!_user) {
        _user = [NSUserDefaults standardUserDefaults];
    }
    return _user;
}
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
    
    
    //获取屏幕亮度
    CGFloat currentLight =   [[UIScreen mainScreen] brightness];
    
    [self.user setFloat:currentLight forKey:@"currentLight"];
    
    
    [self.user synchronize];
    
    //一开始进来时  没有存该app的亮度值
    

    
    //获取设置存的app的屏幕亮度值
    
    if ([self.user objectForKey:@"appLight"]) {
        //将偏好设置里存的值  设置为当前屏幕亮度
            [[UIScreen mainScreen]setBrightness: [self.user floatForKey:@"appLight"]];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
#pragma mark -- 存入数据
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
     UIViewController *view = ((UINavigationController *)self.window.rootViewController).visibleViewController;
    
    if ([view isKindOfClass:[CJLViewController class]]) {
        CJLViewController *cjlna = (CJLViewController *)view;
        [user setInteger:cjlna->selectPageCount forKey:cjlna.fileName];
        [user synchronize];
    }
    
    
    //将之前存到偏好设置里的 外界亮度 在该app离开时重新设置上
      [[UIScreen mainScreen]setBrightness: [user floatForKey:@"currentLight"]];
    
    
    //会调用
    
    
    //失去焦点 进入到多任务
    //将当前的
    
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
