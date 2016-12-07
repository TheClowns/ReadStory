//
//  ViewController.m
//  ReadStory
//
//  Created by 这是C先生 on 2016/12/7.
//  Copyright © 2016年 这是C先生. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,weak) UILabel * lal;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel * lal = [[UILabel alloc]init];
    lal.frame = CGRectMake(0, 0, 100, 100);
    lal.numberOfLines = 0;
    [self.view addSubview:lal];
    lal.text = @"dsdfsdfs";
    self.lal = lal;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self readFile];
//    [self downFile];
}
- (void) readFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *s = [docDir stringByAppendingPathComponent:@"Test.txt"];
    
    NSString *txt = [NSString stringWithContentsOfFile:s encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"%@",txt);
    
    self.lal.text = txt;
    [self.view layoutIfNeeded];
    
}
- (void) downFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/111.txt"];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *s = [docDir stringByAppendingPathComponent:@"Test.txt"];
        
        [data writeToFile:s atomically:YES];
    }]resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
