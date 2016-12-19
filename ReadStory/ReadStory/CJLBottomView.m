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
@interface CJLBottomView ()
{
UILabel *_fLabelView;
}
@property (strong, nonatomic) NSString *errorMessage;
@property (nonatomic,strong) UISlider * lightSlider;
@end

@implementation CJLBottomView

- (UISlider *)lightSlider{
    if (!_lightSlider) {
        _lightSlider = [[UISlider alloc]init];
        [_lightSlider addTarget:self action:@selector(sliderChangeValue:) forControlEvents:UIControlEventValueChanged];
        [_lightSlider setMinimumTrackTintColor:[UIColor grayColor]];
        
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
    [self.lightSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
//        make.height.mas_equalTo(20);
    }];
    
    
}

- (void) sliderChangeValue:(UISlider *)slider{
    NSLog(@"-----%f",slider.value);
    [[UIScreen mainScreen]setBrightness:slider.value];
    
}


@end
