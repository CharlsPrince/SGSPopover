//
//  SGSPopover.m
//  SGSPopover
//
//  Created by charls on 2017/3/7.
//  Copyright © 2017年 CharlsPrince. All rights reserved.
//

#import "SGSPopover.h"

static CGFloat const widthPadding = 10.0;
static CGFloat const heightPadding = 5.0f;
static CGFloat const triangeR = 5.0f;

@interface SGSPopover()
{
    UIView *_contentView;
}
@end

@implementation SGSPopover
@synthesize triangleRaduis = _triangleRaduis;
@synthesize widthEdge = _widthEdge;
@synthesize heightEdge = _heightEdge;
@synthesize popoverStyle = _popoverStyle;
@synthesize cornerRadius = _cornerRadius;

#pragma mark - Lifecycle

- (instancetype)initWithContentView:(UIView *)view {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self commonInitWithView:view];
    }
    return self;
}

- (void)commonInitWithView:(UIView *)view {
    _contentView = view;
    self.backgroundColor = [UIColor clearColor];
//    self.backgroundColor = [UIColor greenColor];
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
}

#pragma mark - Accessors

- (void)setTriangleRaduis:(CGFloat)triangleRaduis {
    _triangleRaduis = triangleRaduis;
    [self updateFrame];
}

- (CGFloat)triangleRaduis {
    return _triangleRaduis ? _triangleRaduis : triangeR;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self updateFrame];
}

- (CGFloat)cornerRadius {
    return _cornerRadius;
}

- (void)setWidthEdge:(CGFloat)widthEdge {
    _widthEdge = widthEdge;
    [self updateFrame];
}

- (CGFloat)widthEdge {
    return _widthEdge ? _widthEdge : widthPadding;
}

- (void)setHeightEdge:(CGFloat)heightEdge {
    _heightEdge = heightEdge;
    [self updateFrame];
}

- (CGFloat)heightEdge {
    return _heightEdge ? _heightEdge : heightPadding;
}

- (void)setPopoverStyle:(SGSPopoverStyle)popoverStyle {
    _popoverStyle = popoverStyle;
    [self updateFrame];
}

- (SGSPopoverStyle)popoverStyle {
    return _popoverStyle;
}


#pragma mark - DrawRect

- (void)updateFrame {
    if (_popoverStyle == SGSPopoverStyleBottom || _popoverStyle == SGSPopoverStyleTop) {
        CGFloat realWidth = _contentView.bounds.size.width + [self widthEdge] * 2;
        CGFloat realHeight = _contentView.bounds.size.height + [self heightEdge] * 2 + [self triangleRaduis];
        self.bounds = CGRectMake(0, 0, realWidth, realHeight);
        self.frame = CGRectMake(100, 100, realWidth, realHeight);
        if (_popoverStyle == SGSPopoverStyleTop) {
            _contentView.center = CGPointMake(realWidth / 2, realHeight / 2 + [self triangleRaduis] / 2);
        } else {
            _contentView.center = CGPointMake(realWidth / 2, realHeight / 2 - [self triangleRaduis] / 2);
        }
    } else if (_popoverStyle == SGSPopoverStyleLeft || _popoverStyle == SGSPopoverStyleRight) {
        CGFloat realWidth = _contentView.bounds.size.width + [self widthEdge] * 2 + [self triangleRaduis];
        CGFloat realHeight = _contentView.bounds.size.height + [self heightEdge] * 2;
        self.bounds = CGRectMake(0, 0, realWidth, realHeight);
        self.frame = CGRectMake(100, 100, realWidth, realHeight);
        if (_popoverStyle == SGSPopoverStyleRight) {
            _contentView.center = CGPointMake(realWidth / 2 - [self triangleRaduis] / 2, realHeight / 2);
        } else {
            _contentView.center = CGPointMake(realWidth / 2 + [self triangleRaduis] / 2, realHeight / 2);
        }
    } else {}
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    /** draw */
    // lineSet
    UIColor *lineColor = _lineColor  ? _lineColor : [UIColor clearColor];
    [lineColor set];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = _lineWidth ? _lineWidth : 0.0f;
    
    [self drawTriangleWithPath:bezierPath triangleRaduis:[self triangleRaduis] withRect:rect];
    
//    [bezierPath closePath];
    [bezierPath stroke];
}

#define degreesToRadians(x) (M_PI*(x)/180.0)

- (void)drawTriangleWithPath:(UIBezierPath *)path triangleRaduis:(CGFloat)triangleRaduis withRect:(CGRect)rect {

//    CGRect rect = self.bounds;
    BOOL isCornerRadius = _cornerRadius > 0 ? YES : NO;
    /** 箭头向上 */
    if (_popoverStyle == SGSPopoverStyleTop) {
        /** 箭头 */
        [path moveToPoint:CGPointMake(rect.size.width / 2 - triangleRaduis, triangleRaduis)];
        [path addLineToPoint:CGPointMake(rect.size.width / 2, 0)];
        [path addLineToPoint:CGPointMake(rect.size.width / 2 + triangleRaduis, triangleRaduis)];
        if (isCornerRadius) {
            [path addLineToPoint:CGPointMake(rect.size.width - _cornerRadius, triangleRaduis)];
            /** 右上圆角 */
            [path addArcWithCenter:CGPointMake(rect.size.width - _cornerRadius, triangleRaduis + _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(270) endAngle:degreesToRadians(0) clockwise:YES];
            [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - _cornerRadius)];
            /** 右下圆角 */
            [path addArcWithCenter:CGPointMake(rect.size.width - _cornerRadius, rect.size.height - _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(0) endAngle:degreesToRadians(90) clockwise:YES];
            [path addLineToPoint:CGPointMake(_cornerRadius, rect.size.height)];
            /** 左下圆角 */
            [path addArcWithCenter:CGPointMake(_cornerRadius, rect.size.height - _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(90) endAngle:degreesToRadians(180) clockwise:YES];
            [path addLineToPoint:CGPointMake(0, _cornerRadius + triangleRaduis)];
            /** 左上圆角 */
            [path addArcWithCenter:CGPointMake(_cornerRadius, _cornerRadius + triangleRaduis) radius:_cornerRadius startAngle:degreesToRadians(180) endAngle:degreesToRadians(270) clockwise:YES];
            [path addLineToPoint:CGPointMake(rect.size.width / 2 - triangleRaduis, triangleRaduis)];
        } else {
            [path addLineToPoint:CGPointMake(rect.size.width, triangleRaduis)];
            [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
            [path addLineToPoint:CGPointMake(0, rect.size.height)];
            [path addLineToPoint:CGPointMake(0, triangleRaduis)];
            [path addLineToPoint:CGPointMake(rect.size.width / 2 - triangleRaduis, triangleRaduis)];
        }
    }
    else if (_popoverStyle == SGSPopoverStyleRight) {
        
        [path moveToPoint:CGPointMake(rect.size.width - triangleRaduis, rect.size.height / 2 - triangleRaduis)];
        [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height / 2)];
        [path addLineToPoint:CGPointMake(rect.size.width - triangleRaduis, rect.size.height / 2 + triangleRaduis)];
        if (isCornerRadius) {
            [path addLineToPoint:CGPointMake(rect.size.width - triangleRaduis, rect.size.height - _cornerRadius)];
            /** 右下圆角 */
            [path addArcWithCenter:CGPointMake(rect.size.width - _cornerRadius - triangleRaduis, rect.size.height - _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(0) endAngle:degreesToRadians(90) clockwise:YES];
            [path addLineToPoint:CGPointMake(_cornerRadius, rect.size.height)];
            
            /** 左下圆角 */
            [path addArcWithCenter:CGPointMake(_cornerRadius, rect.size.height - _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(90) endAngle:degreesToRadians(180) clockwise:YES];
            [path addLineToPoint:CGPointMake(0, _cornerRadius)];
            
            /** 左上圆角 */
            [path addArcWithCenter:CGPointMake(_cornerRadius, _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(180) endAngle:degreesToRadians(270) clockwise:YES];
            [path addLineToPoint:CGPointMake(rect.size.width - _cornerRadius - triangleRaduis, 0)];
            
            /** 右上圆角 */
            [path addArcWithCenter:CGPointMake(rect.size.width - _cornerRadius - triangleRaduis, _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(270) endAngle:degreesToRadians(0) clockwise:YES];
            [path addLineToPoint:CGPointMake(rect.size.width - triangleRaduis, rect.size.height / 2 - triangleRaduis)];
        } else {
            [path addLineToPoint:CGPointMake(rect.size.width - triangleRaduis, rect.size.height - triangleRaduis)];
            [path addLineToPoint:CGPointMake(0, rect.size.height)];
            [path addLineToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(rect.size.width - triangleRaduis, 0)];
            [path addLineToPoint:CGPointMake(rect.size.width - triangleRaduis, rect.size.height / 2 - triangleRaduis)];
        }
    }
    else if (_popoverStyle == SGSPopoverStyleBottom) {
        [path moveToPoint:CGPointMake(rect.size.width / 2 + triangleRaduis, rect.size.height - triangleRaduis)];
        [path addLineToPoint:CGPointMake(rect.size.width / 2, rect.size.height)];
        [path addLineToPoint:CGPointMake(rect.size.width / 2 - triangleRaduis, rect.size.height - triangleRaduis)];
        if (isCornerRadius) {
            [path addLineToPoint:CGPointMake(_cornerRadius, rect.size.height - triangleRaduis)];
            /** 左下圆角 */
            [path addArcWithCenter:CGPointMake(_cornerRadius, rect.size.height - triangleRaduis - _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(90) endAngle:degreesToRadians(180) clockwise:YES];
            [path addLineToPoint:CGPointMake(0, _cornerRadius)];
            /** 左上圆角 */
            [path addArcWithCenter:CGPointMake(_cornerRadius, _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(180) endAngle:degreesToRadians(270) clockwise:YES];
            [path addLineToPoint:CGPointMake(rect.size.width - _cornerRadius, 0)];
            /** 右上圆角 */
            [path addArcWithCenter:CGPointMake(rect.size.width - _cornerRadius, _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(270) endAngle:degreesToRadians(0) clockwise:YES];
            [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - triangleRaduis - _cornerRadius)];
            /** 右下圆角 */
            [path addArcWithCenter:CGPointMake(rect.size.width - _cornerRadius, rect.size.height - triangleRaduis - _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(0) endAngle:degreesToRadians(90) clockwise:YES];
            [path addLineToPoint:CGPointMake(rect.size.width / 2 + triangleRaduis, rect.size.height - triangleRaduis)];
        } else {
            [path addLineToPoint:CGPointMake(0, rect.size.height - triangleRaduis)];
            [path addLineToPoint:CGPointMake(0, 0)];
            [path addLineToPoint:CGPointMake(rect.size.width, 0)];
            [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - triangleRaduis)];
            [path addLineToPoint:CGPointMake(rect.size.width / 2 + triangleRaduis, rect.size.height - triangleRaduis)];
        }
    } else {
        [path moveToPoint:CGPointMake(triangleRaduis, rect.size.height / 2 + triangleRaduis)];
        [path addLineToPoint:CGPointMake(0, rect.size.height / 2)];
        [path addLineToPoint:CGPointMake(triangleRaduis, rect.size.height / 2 - triangleRaduis)];
        if (isCornerRadius) {
            [path addLineToPoint:CGPointMake(triangleRaduis, _cornerRadius)];
            
            [path addArcWithCenter:CGPointMake(_cornerRadius + triangleRaduis, _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(180) endAngle:degreesToRadians(270) clockwise:YES];
            [path addLineToPoint:CGPointMake(rect.size.width - _cornerRadius, 0)];
            
            [path addArcWithCenter:CGPointMake(rect.size.width - _cornerRadius, _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(270) endAngle:degreesToRadians(0) clockwise:YES];
            [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - _cornerRadius)];
            
            [path addArcWithCenter:CGPointMake(rect.size.width - _cornerRadius, rect.size.height - _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(0) endAngle:degreesToRadians(90) clockwise:YES];
            [path addLineToPoint:CGPointMake(triangleRaduis + _cornerRadius, rect.size.height)];
            
            [path addArcWithCenter:CGPointMake(triangleRaduis + _cornerRadius, rect.size.height - _cornerRadius) radius:_cornerRadius startAngle:degreesToRadians(90) endAngle:degreesToRadians(180) clockwise:YES];
            [path addLineToPoint:CGPointMake(triangleRaduis, rect.size.height / 2 + triangleRaduis)];
        } else {
            [path addLineToPoint:CGPointMake(triangleRaduis, 0)];
            [path addLineToPoint:CGPointMake(rect.size.width, 0)];
            [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
            [path addLineToPoint:CGPointMake(triangleRaduis, rect.size.height)];
            [path addLineToPoint:CGPointMake(triangleRaduis, rect.size.height / 2 + triangleRaduis)];
        }
    }
}

@end
