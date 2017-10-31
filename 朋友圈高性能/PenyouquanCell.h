//
//  PenyouquanCell.h
//  朋友圈高性能
//
//  Created by Binbin Mu on 2017/10/27.
//  Copyright © 2017年 Binbin Mu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PenyouquanModal.h"
@interface PenyouquanCell : UITableViewCell
@property(nonatomic ,strong)PenyouquanModal *modal;

@end

@interface ImagesView : UIView
@property(nonatomic ,strong)NSMutableArray *imagesArray;
@end
