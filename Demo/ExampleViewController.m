//
//  ExampleViewController.m
//  KenBurns
//
//  Created by Javier Berlana on 9/23/11.
//  Copyright (c) 2011, Javier Berlana
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this 
//  software and associated documentation files (the "Software"), to deal in the Software 
//  without restriction, including without limitation the rights to use, copy, modify, merge, 
//  publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
//  to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies 
//  or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
//  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
//  IN THE SOFTWARE.
//

#import "ExampleViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ExampleViewController
@synthesize kenView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.kenView.layer.borderWidth = 1;
    self.kenView.layer.borderColor = [UIColor blackColor].CGColor;
    self.kenView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSArray *myImages = @[[UIImage imageNamed:@"image0.jpg"],
                          [UIImage imageNamed:@"image1.jpeg"],
                          [UIImage imageNamed:@"image2.jpeg"],
                          [UIImage imageNamed:@"image3.jpeg"],
                          [UIImage imageNamed:@"image4.png"],
                          [UIImage imageNamed:@"image5.png"]];
    
    [self.kenView animateWithImages:myImages
                 transitionDuration:6
                       initialDelay:0
                               loop:YES
                        isLandscape:YES];
    
    self.statuslabel.text = @"";
}

- (void)viewDidUnload
{
    [self.kenView stopAnimation];
    [self setKenView:nil];
    
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Actions

- (IBAction)stopAnimation:(id)sender
{
    [self.kenView stopAnimation];
}

#pragma mark - KenBurnsViewDelegate

- (void)kenBurns:(JBKenBurnsView *)kenBurns didShowImage:(UIImage *)image atIndex:(NSUInteger)index
{
    self.statuslabel.text = [NSString stringWithFormat:NSLocalizedString(@"Animating image %d (%.2f x %.2f)",),index,image.size.width, image.size.height];
}

- (void)kenBurns:(JBKenBurnsView *)kenBurns didFinishAllImages:(NSArray *)images
{
    NSLog(@"Yay all done!");
}

@end
