//
//  ACDetailsViewController.h
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 06.07.15.
//
//

#import <UIKit/UIKit.h>
#import "ACWalksPreviewCell.h"
#import "ACWalk.h"

@interface ACDetailsViewController : UITableViewController <UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) ACWalk* walkEntity;

@end
