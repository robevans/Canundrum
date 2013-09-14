//
//  editOptionViewController.m
//  Canundrum
//
//  Created by Robert Evans on 16/10/2012.
//  Copyright (c) 2012 Robert Evans. All rights reserved.
//

#import "editOptionViewController.h"
#import "option.h"

@interface editOptionViewController ()
- (void)configureView;
@end

@implementation editOptionViewController

#pragma mark - Managing the detail item

- (void)setOption:(option *)newOption
{
    if (_option != newOption) {
        _option = newOption;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    NSAssert(self.labels.count == self.sliders.count, @"Number of labels must match number of sliders");
    
    for (int i = 0; i<self.labels.count; i++) {
        UILabel * label = self.labels[i];
        UISlider * slider = self.sliders[i];
        if (i<self.attributesList.count) {
            label.text = self.attributesList[i];
        } else {
            label.hidden = YES;
            slider.hidden = YES;
        }
    }
    
    if (self.isAdd == false) {
        self.optionNameField.text = self.option.name;
        for (int i = 0; i<self.attributesList.count; i++) {
            UISlider * slider = self.sliders[i];
            slider.value = [self.option.attributeScores[i] floatValue];
        }
    }
    if (self.isAdd == true) {
    }
}

-(void)saveDataToModel {
    self.option.name = self.optionNameField.text;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<self.attributesList.count; i++) {
        UISlider * slider = self.sliders[i];
        [array addObject:[NSNumber numberWithFloat:slider.value]];
    }
    self.option.attributeScores = array;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    self.optionNameField.delegate = self;
    self.scrollView.delegate = self;
    
    NSComparator compareTags = ^(id a, id b) {
        NSInteger aTag = [a tag];
        NSInteger bTag = [b tag];
        return aTag > bTag ? NSOrderedDescending
        : aTag < bTag ? NSOrderedAscending
        : NSOrderedSame;
    };
    self.labels = [self.labels sortedArrayUsingComparator:compareTags];
    self.sliders = [self.sliders sortedArrayUsingComparator:compareTags];
    [self configureView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self enableOrDisableDoneButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(UIBarButtonItem *)sender {
    NSLog(@"Nav bar done button pressed");
    [self saveDataToModel];
    if (self.isAdd) {
        if ([self.delegate respondsToSelector:@selector(optionDetailViewController:didAddOption:)]) {
            [self.delegate optionDetailViewController:self didAddOption:self.option];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(optionDetailViewController:didEditOption:)]) {
            [self.delegate optionDetailViewController:self didEditOption:self.option];
        }
    }
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    NSLog(@"Cancel button pressed");
    if ([self.delegate respondsToSelector:@selector(optionDetailViewControllerDidCancel:)]) {
        [self.delegate optionDetailViewControllerDidCancel:self];
    }
}

- (IBAction)enableOrDisableDoneButton {
    if (self.optionNameField.text.length>0) {
        self.doneButton.enabled = YES;
    } else {
        self.doneButton.enabled = NO;
    }
}

// Text field delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

// Scroll view delegate methods
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:NO];
}
@end
