//
//  ACFullScreenImageController.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 13.07.15.
//
//

#import "ACFullScreenImageController.h"


@interface ACFullScreenImageController ()

@end

@implementation ACFullScreenImageController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
       [self.walk getImageFromServerWithUrl:self.imageString completionBlock:^(UIImage *image, NSError *error) {
        
        [self.imageView setImage:image];
        
        if(!image) {
            
            NSLog(@"%@", error.description);
        }
    }];
    
    if ([self.walk.walkIllustration hasSuffix:@"/upload/"]) {
        UIImage* image = [UIImage imageNamed:@"No_Image"];
        [self.imageView setImage:image];
    }
}

- (IBAction)backButton:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];

}



@end
