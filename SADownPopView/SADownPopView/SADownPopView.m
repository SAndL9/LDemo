//
//  SADownPopView.m
//  SADownPopView
//
//  Created by 李磊 on 29/6/17.
//  Copyright © 2017年 李磊. All rights reserved.
//

#import "SADownPopView.h"

#define XHHTuanNumViewHight 350.0
#define UI_View_Height [UIScreen mainScreen].bounds.size.height
#define UI_View_Width [UIScreen mainScreen].bounds.size.width
#define UI_navBar_Height 64
@interface SADownPopView ()

/** 从底部弹出的view */
@property (nonatomic, strong) UIView *popContentView;

@end

@implementation SADownPopView



#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviewsContraints];
    }
    return self;
}


- (void)setupSubviewsContraints {
    self.frame = CGRectMake(0, 0, UI_View_Width, XHHTuanNumViewHight);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    if (_popContentView == nil) {
        
        CGFloat margin = 15;
        
        _popContentView = [[UIView alloc]initWithFrame:CGRectMake(0, UI_View_Height - XHHTuanNumViewHight - 64, [UIScreen mainScreen].bounds.size.width, XHHTuanNumViewHight)];
        _popContentView.backgroundColor = [UIColor redColor];
        [self addSubview:_popContentView];
        // 右上角关闭按钮
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake( _popContentView.frame.size.width - 20 - margin, margin, 20, 20);
        [closeBtn setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [_popContentView addSubview:closeBtn];
    }
}
//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_popContentView];
    
    [_popContentView setFrame:CGRectMake(0, UI_View_Height,UI_View_Width, XHHTuanNumViewHight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [_popContentView setFrame:CGRectMake(0, UI_View_Height - XHHTuanNumViewHight, UI_View_Width, XHHTuanNumViewHight)];
        
    } completion:nil];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView {
    
    [_popContentView setFrame:CGRectMake(0, UI_View_Height - XHHTuanNumViewHight, UI_View_Width, XHHTuanNumViewHight)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [_popContentView setFrame:CGRectMake(0, UI_View_Height, UI_View_Width, XHHTuanNumViewHight)];
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         [_popContentView removeFromSuperview];
                         
                     }];
    
}


@end
