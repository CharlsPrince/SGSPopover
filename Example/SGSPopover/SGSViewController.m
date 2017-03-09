//
//  SGSViewController.m
//  SGSPopover
//
//  Created by CharlsPrince on 03/07/2017.
//  Copyright (c) 2017 CharlsPrince. All rights reserved.
//

#import "SGSViewController.h"
#import <SGSPopover/SGSPopover.h>

@interface SGSViewController ()
@property (nonatomic, strong) SGSPopover *popover;
@end

@implementation SGSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"asdfasdfas";
    [label sizeToFit];
    self.popover = [[SGSPopover alloc] initWithContentView:label];
    self.popover.lineWidth = 5.0f;
    self.popover.lineColor = [UIColor redColor];
    self.popover.fillColor = [UIColor greenColor];
    self.popover.triangleRaduis = 5.0f;
    self.popover.widthEdge = 10.0;
    self.popover.heightEdge = 10.0f;
    self.popover.cornerRadius = 5.0f;
    self.popover.popoverStyle = SGSPopoverStyleLeft;
    [self.view addSubview:self.popover];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(100, 180, 100, 30)];
    [slider addTarget:self action:@selector(cornerRaduisChange:) forControlEvents:UIControlEventValueChanged];
    slider.minimumValue = 0;
    slider.maximumValue = 10;
    [self.view addSubview:slider];
    
    UISlider *slider2 = [[UISlider alloc] initWithFrame:CGRectMake(100, 250, 100, 30)];
    [slider2 addTarget:self action:@selector(triangleRaduisChange:) forControlEvents:UIControlEventValueChanged];
    slider2.minimumValue = 0;
    slider2.maximumValue = 10;
    [self.view addSubview:slider2];
    
    UISlider *slider3 = [[UISlider alloc] initWithFrame:CGRectMake(100, 300, 100, 30)];
    [slider3 addTarget:self action:@selector(popStyleChange:) forControlEvents:UIControlEventValueChanged];
    slider3.minimumValue = 0.0;
    slider3.maximumValue = 3.4;
    [self.view addSubview:slider3];
    
}

- (void)cornerRaduisChange:(UISlider *)slider {
    self.popover.cornerRadius = slider.value;
}

- (void)triangleRaduisChange:(UISlider *)slider {
    self.popover.triangleRaduis = slider.value;
}

- (void)popStyleChange:(UISlider *)slider {
    self.popover.popoverStyle = (int)slider.value;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
