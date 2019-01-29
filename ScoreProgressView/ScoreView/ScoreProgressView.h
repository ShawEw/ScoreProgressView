//
//  HZScoreView.h
//  Common
//
//  Created by jiang junhui on 2019/1/29.
//  Copyright © 2019 hongzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreProgressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScoreProgressView : UIView

-(instancetype)initWithFrame:(CGRect)frame model:(ScoreProgressModel *)model;

@property (nonatomic, strong) ScoreProgressModel *model;

@end

NS_ASSUME_NONNULL_END
