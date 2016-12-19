//
//  CJLBottomView.m
//  ReadStory
//
//  Created by 这是C先生 on 2016/12/12.
//  Copyright © 2016年 这是C先生. All rights reserved.
//

#import "CJLBottomView.h"
#import <CoreText/CoreText.h>
#import <Masonry.h>
#define KBtnWidth 50
@interface CJLBottomView ()
{
UILabel *_fLabelView;
}
@property (strong, nonatomic) NSString *errorMessage;
@property (nonatomic,strong) UISlider * lightSlider;
@property (nonatomic,strong) UIView * fontChangeView;
@end

@implementation CJLBottomView
- (UIView *)fontChangeView{
    if (!_fontChangeView) {
        _fontChangeView = [[UIView alloc]init];
        [self addFontButton];
        [self addSubview:_fontChangeView];
    }
    return _fontChangeView;
}
- (void) addFontButton{
    CGFloat margin =  (KWidth - 5*KBtnWidth)/6;
    for (int i = 0;i < 5;i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = KBtnWidth/2;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 14 + i;
        [btn setTitle:[NSString stringWithFormat:@"%ld",btn.tag] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i*(50 + margin)+margin , 0, 50, 50);
        btn.backgroundColor = [UIColor lightGrayColor];
        [self.fontChangeView addSubview:btn];
    }
}
- (UISlider *)lightSlider{
    if (!_lightSlider) {
        _lightSlider = [[UISlider alloc]init];
        [_lightSlider addTarget:self action:@selector(sliderChangeValue:) forControlEvents:UIControlEventValueChanged];
        [_lightSlider setMinimumTrackTintColor:[UIColor grayColor]];
        _lightSlider.value = [[[NSUserDefaults standardUserDefaults]valueForKey:@"currentLight"]floatValue];

        [self addSubview:_lightSlider];
    }
    return _lightSlider;
}

- (instancetype)initWithFrame:(CGRect)frame{
   self =  [super initWithFrame: frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.6;
        [self setView];
    }
    return self;
}
- (void) setView{
#pragma mark -- 设置调节屏幕亮度的slider
    [self.lightSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.height.mas_equalTo(31);
    }];
    
#pragma mark -- 设置字体大小view
    [self.fontChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lightSlider.mas_bottom).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(50);
    }];
    
    
    
    
    
}
#pragma mark -- 需改屏幕亮度
- (void) sliderChangeValue:(UISlider *)slider{
    
    NSLog(@"-----%f",slider.value);
    [[UIScreen mainScreen]setBrightness:slider.value];
    self.appLight = slider.value;
}

#pragma mark -- 更改字体大小 
- (void) btnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(CJLBottomViewBtnClick:)]) {
        [self.delegate performSelector:@selector(CJLBottomViewBtnClick:) withObject:sender];
    }
}
@end
