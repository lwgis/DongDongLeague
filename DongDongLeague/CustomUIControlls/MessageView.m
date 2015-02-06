//
//  MessageView.m
//  iPhoneDianCan
//
//  Created by 李炜 on 13-4-1.
//  Copyright (c) 2013年 ztb. All rights reserved.
//

#import "MessageView.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
@implementation MessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(id)messageViewWithMessageText:(NSString *)message{
    MessageView *mv = [[MessageView alloc] init];
        UIView *bgView=[[UIView alloc] init];
        bgView.tag=1;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.7;
        bgView.layer.cornerRadius = 5;
        bgView.layer.masksToBounds = YES;
        [mv addSubview:bgView];
        UILabel *label=[[UILabel alloc] init];
        label.backgroundColor=[UIColor clearColor];
        label.textColor=[UIColor whiteColor];
        label.font=[UIFont fontWithName:@"Helvetica-Bold" size:14];
        label.tag=2;
        [label setText:message];
        [label sizeToFit];
        CGRect bgRect=label.frame;
        bgRect.size.width+=40;
        bgRect.size.height+=20;
        [bgView setFrame:bgRect];
        CGRect lbRect=label.frame;
        lbRect.origin.x=(bgRect.size.width-lbRect.size.width)/2;
        lbRect.origin.y=(bgRect.size.height-lbRect.size.height)/2;
        [label setFrame:lbRect];
        [mv addSubview:label];
        bgRect.origin.x=(SCREENWIDTH-bgRect.size.width)/2;
        bgRect.origin.y=(SCREENHEIGHT-TABBARHEIGHT-bgRect.size.height)/2;
        [mv setFrame:bgRect];
        mv.alpha=0;
    return mv;
}
-(void)show{
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

-(void)showWithDuration:(NSTimeInterval)duration{
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window.rootViewController.view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:duration options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.alpha=0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
