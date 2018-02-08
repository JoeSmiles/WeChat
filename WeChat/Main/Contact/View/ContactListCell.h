//
//  ContactListCell.h
//  WeChat
//
//  Created by admin on 2018/1/18.
//  Copyright © 2018年 zjw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactModel;

@interface ContactListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fengeline;

@property (nonatomic, strong) ContactModel *model;

@end
