//
//  ChatListCell.m
//  WeChat
//
//  Created by admin on 2018/1/18.
//  Copyright © 2018年 zjw. All rights reserved.
//

#import "ChatListCell.h"

@implementation ChatListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self initView];
    
}

- (void)initView
{
    self.headImage.layer.cornerRadius = 5;
    self.headImage.layer.masksToBounds = YES;
    
    self.stateView.layer.cornerRadius = 5;
    self.stateView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
