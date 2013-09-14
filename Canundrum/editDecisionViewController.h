//
//  editDecisionViewController.h
//  Canundrum
//
//  Created by Robert Evans on 08/09/2013.
//  Copyright (c) 2013 Robert Evans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class decision;

@protocol editDecisionDelegate;

@interface editDecisionViewController : UIViewController <UITextFieldDelegate>
    - (IBAction)cancel:(UIBarButtonItem *)sender;
    - (IBAction)done:(UIBarButtonItem *)sender;

    @property (strong, nonatomic) decision *selectedDecision;
    @property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
    @property (weak, nonatomic) IBOutlet UITextField *decisionNameField;
    @property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *attributeFields;
    @property (strong, nonatomic) IBOutletCollection(UISlider) NSArray *attributeSliders;
    @property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

    @property (nonatomic, weak) id<editDecisionDelegate> delegate;
@end

@protocol editDecisionDelegate <NSObject>

- (void)editDecisionViewController:(editDecisionViewController *)viewController didEditDecision:(decision *)decision;
- (void)editDecisionViewControllerDidCancel:(editDecisionViewController *)viewController;

@end