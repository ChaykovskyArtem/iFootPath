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
@protocol previewCellDelegate;

@interface ACDetailsViewController : UITableViewController <UITextViewDelegate, UITextFieldDelegate, previewCellDelegate>

@property (strong, nonatomic) ACWalk* walkEntity;

@end
