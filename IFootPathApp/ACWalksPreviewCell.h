//
//  ACWalksPreviewCell.h
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import <UIKit/UIKit.h>

@interface ACWalksPreviewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel* title;
@property (strong, nonatomic) IBOutlet UIImageView* difficalty;
@property (strong, nonatomic) IBOutlet UIImageView* rating;
@property (strong, nonatomic) IBOutlet UIImageView* walkIcon;
@property (strong, nonatomic) IBOutlet UILabel* typeLabel;
@property (strong, nonatomic) IBOutlet UILabel* countryLabel;



@end
