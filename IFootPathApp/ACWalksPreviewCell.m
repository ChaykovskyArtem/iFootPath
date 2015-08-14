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
    
    self.delegate = self.mainController;

    [self.delegate viewWalkOnCell:self];
    
}

- (IBAction)deleteWalk:(UIButton *)sender {
    
        self.delegate = self.mainController;

        [self.delegate deleteWalkOnCell:self];
    
}
@end
