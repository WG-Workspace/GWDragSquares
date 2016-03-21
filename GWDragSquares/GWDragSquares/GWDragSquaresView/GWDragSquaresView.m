//
//  GWDragSquaresView.m
//  GWDragSquares
//
//  Created by Commoner on 16/3/21.
//  Copyright © 2016年 Commoner. All rights reserved.
//

#import "GWDragSquaresView.h"

#define GW_COUNT 9
#define GW_MARGIN 50

@interface GWDragSquaresView ()

@property (nonatomic, assign) BOOL contain;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint originPoint;

@property (nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation GWDragSquaresView

/**
 *  重写初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      
        [self updateUI];
        
    }
    return self;
}

/**
 *  更新UI
 */
- (void)updateUI {
    
    for (NSInteger i =0; i< GW_COUNT; i++) {
        
        CGFloat btn_W = ([UIScreen mainScreen].bounds.size.width - GW_MARGIN *2)/3;
        CGFloat btn_H = btn_W;
        
        CGFloat btn_X = GW_MARGIN + btn_W * (i%3);
        CGFloat btn_Y = GW_MARGIN + btn_H * (i/3);
        

        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor orangeColor];
        btn.frame = CGRectMake(btn_X, btn_Y, btn_W, btn_H);
        
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        
        btn.tag = i;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [btn setTitle:[NSString stringWithFormat:@"%ld",1+i] forState:UIControlStateNormal];
        
        [self addSubview:btn];
        
        // 添加长按手势
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(buttonLongPressed:)];
        [btn addGestureRecognizer:longGesture];
        
        [self.itemArray addObject:btn];
        
        
    }
    
}


- (void)buttonLongPressed:(UILongPressGestureRecognizer *)sender {

    UIButton *btn = (UIButton *)sender.view;
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        self.startPoint = [sender locationInView:sender.view];
        self.originPoint = btn.center;
        
        [UIView animateWithDuration:0.25 animations:^{
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
        }];
        
    }else if (sender.state == UIGestureRecognizerStateChanged) {
    
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x - self.startPoint.x;
        CGFloat deltaY = newPoint.y - self.startPoint.y;
        
        NSLog(@"%lf",deltaX);
        NSLog(@"%lf",deltaY);
        
        btn.center = CGPointMake(btn.center.x + deltaX, btn.center.y + deltaY);
        
        NSInteger index = [self indexOfPoint:btn.center withButton:btn];
        
        if (index < 0) {
            self.contain = NO;
        }else {
            [UIView animateWithDuration:0.25 animations:^{
               
                CGPoint temp = CGPointZero;
                UIButton *button = _itemArray[index];
                temp = button.center;
                button.center = self.originPoint;
                btn.center = temp;
                self.originPoint = btn.center;
                self.contain = YES;
                
            }];
        
        }
    }else if (sender.state == UIGestureRecognizerStateEnded) {
    
        [UIView animateWithDuration:0.25 animations:^{
           
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            
            if (!self.contain) {
                btn.center = self.originPoint;
            }
            
            
        }];
    
    
    }

}


- (NSInteger)indexOfPoint:(CGPoint)point withButton:(UIButton *)btn {

    for (NSInteger i =0; i<self.itemArray.count; i++) {
        UIButton *button = self.itemArray[i];
        
        if (button != btn) {
            
            if (CGRectContainsPoint(button.frame, point)) {
                return i;
            }
            
        }
    }
    return -1;
}





/**
 *  懒加载
 */
- (NSMutableArray *)itemArray {
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}


@end
