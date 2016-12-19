//
//  CJLViewController.m
//  ReadStory
//
//  Created by 这是C先生 on 2016/12/8.
//  Copyright © 2016年 这是C先生. All rights reserved.
//

#import "CJLViewController.h"
#import <MBProgressHUD.h>
#import "CJLBottomView.h"
#define Kmargin 10
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
#define TextInfo @"TextInfo"
//static  NSInteger selectPageCount;
@interface CJLViewController ()<MBProgressHUDDelegate>
{
    BOOL isTap;
 
    NSInteger finalCount;
    

//    NSInteger
}
@property (nonatomic,strong) NSMutableArray * textArray;
@property (nonatomic,strong) UIView * leftView;
@property (nonatomic,strong) UIView * rightView;
@property (nonatomic,strong) UIView * centerView;
@property (nonatomic,strong) UILabel * label;
@property (nonatomic,strong) CJLBottomView * bottomView;
@property (nonatomic,strong) MBProgressHUD * hud;
@property (nonatomic,strong) UIView * topView;

@end
@implementation CJLViewController
#pragma mark -- 底部 view
- (CJLBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[CJLBottomView alloc]initWithFrame:CGRectMake(0, KHeight - 100, KWidth, 100)];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}
#pragma mark -- 顶部view
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth, 40)];
        _topView.backgroundColor= [UIColor whiteColor];
        _topView.alpha = 0.4;
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(0, 0, 60, 40);
        [b addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:b];
        b.backgroundColor = [UIColor redColor];
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (MBProgressHUD *)hud{
    if (!_hud) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _hud.delegate = self;
    }
    return _hud;
}
- (NSMutableArray *)textArray{
    if (!_textArray) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}
- (void)viewDidLoad {
    
#pragma mark-- 获取当前位置等一系列关于当前文件的设置
    
      NSNumber *pageSelectCountNumber = [[NSUserDefaults standardUserDefaults] valueForKey:self.fileName];
    if (pageSelectCountNumber) {
        //将获取到的当前选择的页数赋值上去
        selectPageCount = pageSelectCountNumber.integerValue;
    }

    
    
    
    
    
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.label.text = @"正在加载内容....";
    [self.hud showAnimated:NO];
    
    
    
    self.view.userInteractionEnabled = NO;
    isTap = NO;
    
    
    
    self.view.backgroundColor = [UIColor grayColor];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self perpareUILabel];
    [self setUpView];
    
}
- (void) setUpView{
    
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth /3, KHeight)];
    [self.view addSubview:self.leftView];
//    self.leftView.backgroundColor = [UIColor redColor];
    self.leftView.alpha = 0.3;
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftTapClick)];
    [self.leftView addGestureRecognizer:leftTap];
    
    
    
    
    self.centerView = [[UIView alloc]initWithFrame:CGRectMake(KWidth/3, 0, KWidth /3, KHeight)];
    [self.view addSubview:self.centerView];
//    self.centerView.backgroundColor = [UIColor greenColor];
    self.centerView.alpha = 0.3;
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
    [self.centerView addGestureRecognizer:centerTap];
    
    
    
    
    self.rightView = [[UIView alloc]initWithFrame:CGRectMake(KWidth*2/3, 0, KWidth /3, KHeight)];
    [self.view addSubview:self.rightView];
//    self.rightView.backgroundColor = [UIColor blueColor];
    self.rightView.alpha = 0.3;
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTapClick)];
    [self.rightView addGestureRecognizer:rightTap];
    
    
    
    
}
- (void) leftTapClick{
    if (selectPageCount != 0) {
        selectPageCount--;
        self.label.text = self.textArray[selectPageCount];
        CGRect rect = [self.label.text boundingRectWithSize:CGSizeMake(KWidth - 2 * Kmargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:16]} context:nil];
        NSLog(@"%@ ,%lu ,%@ ",self.label.text,self.label.text.length,NSStringFromCGRect(rect));
    }else{
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经到首页了" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertC addAction:actionCancel];
        [self presentViewController:alertC animated:YES completion:nil];
        
        
//        NSLog(@"到头了");
    }
}
- (void) rightTapClick{
    
    if (selectPageCount < finalCount - 1) {
        selectPageCount++;
        self.label.text = self.textArray[selectPageCount];
        CGRect rect = [self.label.text boundingRectWithSize:CGSizeMake(KWidth - 2 * Kmargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:16]} context:nil];
         NSLog(@"%@ ,%lu ,%@ ",self.label.text,self.label.text.length,NSStringFromCGRect(rect));
    }else{
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经到尾页了" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertC addAction:actionCancel];
        [self presentViewController:alertC animated:YES completion:nil];
//        NSLog(@"到头了");
    }
    
}
- (void) centerTapClick{
    if (isTap) {
        [self.topView setHidden:YES];
        [self.bottomView setHidden:YES];
        isTap = NO;
    }else{
        isTap = YES;
        [self.topView setHidden:NO];
        [self.bottomView setHidden:NO];
        //自动隐藏
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //            isTap = NO;
//        [self.topView setHidden:YES];
//        [self.bottomView setHidden:YES];
//
//        });
        
        
    }
    
}
- (void) btnClick{
#pragma mark --将当前的坐标等存到偏好设置中  
    
    
    
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:@(selectPageCount) forKey:self.fileName];
    
    [user synchronize];
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) perpareUILabel{
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(Kmargin, 0, KWidth - 2 * Kmargin, KHeight)];
    [self.view addSubview:self.label];
    self.label.numberOfLines = 0;
    self.label.adjustsFontSizeToFitWidth = YES;
//    self.label.lineBreakMode = NSLineBreakByCharWrapping;
//    self.label.textAlignment = NSTextAlignmentLeft;
    
    [self setLabelFont:16];
    
}




#pragma mark -- 设置字体大小
- (void) setLabelFont:(CGFloat )fontSize{
    //先获取当前显示的首个字符的位置  根据当前首个字符的位置来更改字体的大小  来更改总页数 单页字数
    //获取到当前页的首字符的位置
//    NSInteger textLoc = selectPageCount * pageTextCount;
    
    
    
    self.label.font = [UIFont systemFontOfSize:fontSize];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *s = [docDir stringByAppendingPathComponent:self.fileName];
        //获取到文件
        NSString *text = [NSString stringWithContentsOfFile:s encoding:NSUTF8StringEncoding error:nil];
        //计算总面积
        CGRect rect = [text boundingRectWithSize:CGSizeMake(KWidth - 2 * Kmargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:fontSize]} context:nil];
        
        //计算大概页数
       NSInteger  pageCount = (int)(rect.size.height / KHeight) + 1;
        
        
        //每一页的字数
        NSInteger count =  text.length / pageCount;
        //将现在计算出的单页字数存起来 以供下次使用
        pageTextCount = count;
        
        //总字数
        NSInteger allCount = text.length;
        
        
        //总页数
        finalCount = (allCount / count)+1;
        
        
        NSLog(@"finalCount  = %lu",finalCount);
        
        
        for (int i = 0;i < finalCount - 1;i ++) {
            NSString *temp = [text substringWithRange:NSMakeRange(i* count, count)];
            [self.textArray addObject:temp];
        }
        NSString *ss = [text substringFromIndex:(finalCount - 1)* count];
        [self.textArray addObject:ss];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.hud hideAnimated:NO];
            self.view.userInteractionEnabled = YES;
            
            self.label.text = self.textArray[selectPageCount];
            CGRect rect = [self.label.text boundingRectWithSize:CGSizeMake(KWidth - 2 * Kmargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:fontSize]} context:nil];
            
            
            NSLog(@"%@ ,%lu ,%@ ",self.label.text,self.label.text.length,NSStringFromCGRect(rect));
            [self.view layoutIfNeeded];
        });
        
    });
    
}
- (void)dealloc{
    NSLog(@"销毁了");
}
@end
