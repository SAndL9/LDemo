//
//  PGCardTableViewCell.h
//  PerfectVideoEditor
//
//  Created by zangqilong on 14/12/4.
//  Copyright (c) 2014年 zangqilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PGCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cardView;
- (void)startAnimationWithDelay:(CGFloat)delayTime;
@end
