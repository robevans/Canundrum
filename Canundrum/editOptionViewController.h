//
//  editOptionViewController.h
//  Canundrum
//
//  Created by Robert Evans on 16/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "option.h"

@protocol editOptionDelegate;

@interface editOptionViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>

    - (IBAction)done:(UIBarButtonItem *)sender;
    - (IBAction)cancel:(UIBarButtonItem *)sender;
    - (IBAction)enableOrDisableDoneButton;

    @property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
    @property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

    @property (weak, nonatomic) IBOutlet UITextField *optionNameField;
    @property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
    @property (strong, nonatomic) IBOutletCollection(UISlider) NSArray *sliders;

    @property (nonatomic, weak) id<editOptionDelegate> delegate;

    @property (strong, nonatomic) option *option;
    @property (weak, nonatomic) NSMutableArray *attributesList;

    @property (nonatomic) BOOL isAdd;

@end

@protocol editOptionDelegate <NSObject>

    - (void)optionDetailViewController:(editOptionViewController *)viewController didAddOption:(option *)option;
    - (void)optionDetailViewController:(editOptionViewController *)viewController didEditOption:(option *)option;
    - (void)optionDetailViewControllerDidCancel:(editOptionViewController *)viewController;

@end