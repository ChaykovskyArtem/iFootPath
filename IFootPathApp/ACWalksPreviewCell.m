//
//  ACWalksPreviewCell.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import "ACWalksPreviewCell.h"

@implementation ACWalksPreviewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (IBAction)viewWalk:(UIButton *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    ACDetailsViewController* detailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"identifier"];
    self.delegate = detailsViewController;

    [self.delegate viewWalkOnCell:self];
    
}

- (IBAction)deleteWalk:(UIButton *)sender {
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Walk was deleted" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    ACDetailsViewController* detailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"identifier"];
    self.delegate = detailsViewController;

    [self.delegate deleteWalkOnCell:self];
    
}
@end
