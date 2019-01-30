# ScoreProgressView
自定义分值显示进度条

![效果图](https://github.com/ShawEw/ScoreProgressView/ScoreProgressView/pic.png)  

## 使用方法  
### cocoapods
  pod 'ScoreProgressView'
  
### 代码使用

    ```
    ScoreProgressModel *model = [[ScoreProgressModel alloc] init];
    model.finalScore = 80;//最终得分
    model.info = [NSString stringWithFormat:@"我的系统活跃指数:%ld",model.finalScore];
    model.minScore = 0;//最低分
    model.maxScore = 100;//最高分
    model.progressColor = APP_MAIN_COLOR;//系统颜色值
    model.scoreFont = 13;//分数字体大小
    model.bgHeight = 15;//进度条高度
    ScoreProgressView *view = [[ScoreProgressView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 150) model:model];
    [self.view addSubview:view];
    ```
