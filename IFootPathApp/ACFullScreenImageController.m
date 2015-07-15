//
//  ACFullScreenImageController.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 13.07.15.
//
//

#import "ACFullScreenImageController.h"
#import <AFNetworking.h>
#import "UIKit+AFNetworking.h"


@interface ACFullScreenImageController ()

@end

@implementation ACFullScreenImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL* url = [NSURL URLWithString:self.imageString];
    [self.imageView setImageWithURL:url];
    
    if ([self.imageString hasSuffix:@"/upload/"]) {
        UIImage* image = [UIImage imageNamed:@"No_Image"];
        [self.imageView setImage:image];
    }
}

- (IBAction)backButton:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];

}



@end
