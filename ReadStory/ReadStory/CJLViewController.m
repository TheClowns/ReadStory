//
//  CJLViewController.m
//  ReadStory
//
//  Created by 这是C先生 on 2016/12/8.
//  Copyright © 2016年 这是C先生. All rights reserved.
//

#import "CJLViewController.h"
#import "CJLCollection.h"
#import "CJLCollectionViewFlowLayout.h"
#define Kmargin 10
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
@interface CJLViewController ()
{
    int pageCount;
    BOOL isTap;
    NSInteger selectPageCount;
}
@property (nonatomic,strong) NSMutableArray * textArray;
@property (nonatomic,strong) UIView * leftView;
@property (nonatomic,strong) UIView * rightView;
@property (nonatomic,strong) UIView * centerView;
@property (nonatomic,strong) UILabel * label;
@property (nonatomic,weak) UIView * v;

@end
@implementation CJLViewController
- (NSMutableArray *)textArray{
    if (!_textArray) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}
- (void)viewDidLoad {
    
    isTap = NO;
    selectPageCount = 0;
    
    
    self.view.backgroundColor = [UIColor grayColor];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self perpareUILabel];
    [self setUpView];
    
}
- (void) setUpView{
    
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth /3, KHeight)];
    [self.view addSubview:self.leftView];
    self.leftView.backgroundColor = [UIColor redColor];
    self.leftView.alpha = 0.3;
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftTapClick)];
    [self.leftView addGestureRecognizer:leftTap];
    
    
    
    
    self.centerView = [[UIView alloc]initWithFrame:CGRectMake(KWidth/3, 0, KWidth /3, KHeight)];
    [self.view addSubview:self.centerView];
    self.centerView.backgroundColor = [UIColor greenColor];
    self.centerView.alpha = 0.3;
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
    [self.centerView addGestureRecognizer:centerTap];
    
    
    
    
    self.rightView = [[UIView alloc]initWithFrame:CGRectMake(KWidth*2/3, 0, KWidth /3, KHeight)];
    [self.view addSubview:self.rightView];
    self.rightView.backgroundColor = [UIColor blueColor];
    self.rightView.alpha = 0.3;
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTapClick)];
    [self.rightView addGestureRecognizer:rightTap];
    
    
    
    
}
- (void) leftTapClick{
    if (selectPageCount != 0) {
        selectPageCount--;
        self.label.text = self.textArray[selectPageCount];
    }else{
        NSLog(@"到头了");
    }
}
- (void) rightTapClick{
    
    if (selectPageCount < pageCount) {
        selectPageCount++;
        self.label.text = self.textArray[selectPageCount];
    }else{
        NSLog(@"到头了");
    }
    
}
- (void) centerTapClick{
    if (isTap) {
        [self.v removeFromSuperview];
        isTap = NO;
        return;
    }else{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth, 40)];
    v.backgroundColor = [UIColor whiteColor];
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(0, 0, 60, 40);
    [b addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:b];
    b.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
        isTap = YES;
        self.v = v;
    }
    
}
- (void) btnClick{
    [self dismissViewControllerAnimated:NO completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }];
}

- (void) perpareUILabel{
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(Kmargin, 0, KWidth - 2 * Kmargin, KHeight)];
    [self.view addSubview:self.label];
//    self.label.backgroundColor = [UIColor greenColor];
    self.label.numberOfLines = 0;
    self.label.lineBreakMode = NSLineBreakByCharWrapping;
    self.label.font = [UIFont systemFontOfSize:16];
    self.label.textAlignment = NSTextAlignmentLeft;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *s = [docDir stringByAppendingPathComponent:self.fileName];
        NSString *text = [NSString stringWithContentsOfFile:s encoding:NSUTF8StringEncoding error:nil];
        CGRect rect = [text boundingRectWithSize:CGSizeMake(KWidth - 2 * Kmargin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:16]} context:nil];
        pageCount = (int)(rect.size.height / KHeight) + 1;
        NSLog(@"---------%d------- %f",pageCount,rect.size.height/KHeight);
        
        NSLog(@"%f,%lu ",text.length / 2846.0,(unsigned long)text.length);
        
        
        
        for (int i = 0;i < pageCount - 1;i ++) {
            NSString *temp = [text substringWithRange:NSMakeRange(i* (text.length / pageCount), text.length / pageCount)];
            [self.textArray addObject:temp];
        }
        NSString *ss = [text substringFromIndex:(pageCount - 1)*(text.length / pageCount)];
        [self.textArray addObject:ss];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = self.textArray[selectPageCount];
            [self.view layoutIfNeeded];
        });
       
    });
    
    
}
- (void) perpareConllectionView{
    
    
    CJLCollectionViewFlowLayout *layout = [[CJLCollectionViewFlowLayout alloc]init];
    CJLCollection *cv = [[CJLCollection alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    [self.view addSubview:cv];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *s = [docDir stringByAppendingPathComponent:self.fileName];
        //        NSString *text = [NSString stringWithContentsOfFile:s encoding:NSUTF8StringEncoding error:nil];
//                NSLog(@"%@",text);
    });
}
- (void)dealloc{
    NSLog(@"sdsds");
}
@end
