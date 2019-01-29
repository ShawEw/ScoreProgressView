//
//  TriangleView.m
//  Common
//
//  Created by jiang junhui on 2019/1/29.
//  Copyright © 2019 hongzheng. All rights reserved.
//

#import "TriangleView.h"
@interface TriangleView ()
{
    CGPoint _startPoint;
    CGPoint _middlePoint;
    CGPoint _endPoint;
    UIColor  *_color;
}

@end


@implementation TriangleView

- (instancetype)initStartPoint:(CGPoint)startPoint middlePoint:(CGPoint)middlePoint endPoint:(CGPoint)endPoint color:(UIColor*)color {
    self = [super init];
    if (self) {
        _startPoint = startPoint;
        _middlePoint = middlePoint;
        _endPoint = endPoint;
        _color = color;
        self.backgroundColor = [UIColor clearColor];}return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, _startPoint.x, _startPoint.y);CGContextAddLineToPoint(context,_middlePoint.x, _middlePoint.y);CGContextAddLineToPoint(context,_endPoint.x, _endPoint.y);CGContextClosePath(context);//路径结束标志，不写默认封闭
    [_color setFill]; //设置填充色
    [_color setStroke];//边框也设置为_color，否则为默认的黑色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}
@end
