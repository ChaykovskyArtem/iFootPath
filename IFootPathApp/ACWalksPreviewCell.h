//
//  ACWalksPreviewCell.h
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import <UIKit/UIKit.h>
#import "ACDetailsViewController.h"
#import "ACMainViewContoller.h"
@protocol previewCellDelegate;

@interface ACWalksPreviewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel* title;
@property (strong, nonatomic) IBOutlet UIImageView* difficalty;
@property (strong, nonatomic) IBOutlet UIImageView* rating;
@property (strong, nonatomic) IBOutlet UIImageView* walkIcon;
@property (strong,nonatomic) NSIndexPath* indexPath;
@property (strong, nonatomic) ACMainViewContoller* mainController;
@property (weak, nonatomic) id <previewCellDelegate> delegate;




- (IBAction)viewWalk:(UIButton *)sender;


- (IBAction)deleteWalk:(UIButton *)sender;


@end

@protocol previewCellDelegate <NSObject>

-(void) viewWalkOnCell:(ACWalksPreviewCell*)cell;

-(void) deleteWalkOnCell:(ACWalksPreviewCell*)cell;


@end
