//
//  TriangleView.h
//  Common
//
//  Created by jiang junhui on 2019/1/29.
//  Copyright © 2019 hongzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TriangleView : UIView
- (instancetype)initStartPoint:(CGPoint)startPoint middlePoint:(CGPoint)middlePoint endPoint:(CGPoint)endPoint color:(UIColor*)color;
@end

NS_ASSUME_NONNULL_END
