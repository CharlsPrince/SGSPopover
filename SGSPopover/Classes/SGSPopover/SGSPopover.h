//
//  SGSPopover.h
//  SGSPopover
//
//  Created by charls on 2017/3/7.
//  Copyright © 2017年 CharlsPrince. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SGSPopoverStyle) {
    SGSPopoverStyleBottom = 0,       //! 箭头向下
    SGSPopoverStyleLeft, //! 箭头向左
    SGSPopoverStyleTop,      //! 箭头向上
    SGSPopoverStyleRight   //!  箭头向右
};

@interface SGSPopover : UIView

@property (nonatomic, assign) CGFloat lineWidth;  
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGFloat triangleRaduis;
@property (nonatomic, assign) CGFloat widthEdge;
@property (nonatomic, assign) CGFloat heightEdge;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) SGSPopoverStyle popoverStyle;

/**
 初始化Popover对象

 @param view 内嵌视图
 @return Popover对象
 */
- (instancetype)initWithContentView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
