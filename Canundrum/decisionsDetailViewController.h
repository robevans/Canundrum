//
//  decisionsDetailViewController.h
//  Canundrum
//
//  Created by Robert Evans on 16/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface decisionsDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
