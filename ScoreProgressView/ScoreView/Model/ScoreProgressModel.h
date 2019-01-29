//
//  HZScoreModel.h
//  Common
//
//  Created by jiang junhui on 2019/1/29.
//  Copyright © 2019 hongzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ScoreProgressModel : NSObject

@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) NSInteger minScore;
@property (nonatomic, assign) CGFloat scoreFont;
@property (nonatomic, assign) CGFloat scoreWidth;//会根据font 计算
@property (nonatomic, assign) NSInteger maxScore;
@property (nonatomic, assign) NSInteger finalScore;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, assign) CGFloat bgHeight;

@end

NS_ASSUME_NONNULL_END
