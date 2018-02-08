//
//  ChatListCell.h
//  WeChat
//
//  Created by admin on 2018/1/18.
//  Copyright © 2018年 zjw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *silentImage;

@end
