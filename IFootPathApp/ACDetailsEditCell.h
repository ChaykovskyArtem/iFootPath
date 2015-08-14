//
//  ACDetailsEditCell.h
//  iFootPathApp
//
//  Created by Artem Chaykovsky on 07.07.15.
//
//

#import <UIKit/UIKit.h>

@interface ACDetailsEditCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UITextField* titleTextField;
@property (weak,nonatomic) IBOutlet UITextField* countryTextField;
@property (weak,nonatomic) IBOutlet UITextField* typeTextField;
@property (weak,nonatomic) IBOutlet UITextField* districtTextField;
@property (weak,nonatomic) IBOutlet UITextField* lengthTextField;
@property (weak,nonatomic) IBOutlet UITextField* startCoordLatTextField;
@property (weak,nonatomic) IBOutlet UITextField* startCoordLongTextField;
@property (weak,nonatomic) IBOutlet UITextField* gradeTextField;
@property (weak,nonatomic) IBOutlet UITextField* ratingTextField;
@property (weak,nonatomic) IBOutlet UITextField* versionField;
@property (weak,nonatomic) IBOutlet UITextField* IDField;


@property (weak,nonatomic) IBOutlet UILabel* titleLabel;
@property (weak,nonatomic) IBOutlet UILabel* countryLabel;
@property (weak,nonatomic) IBOutlet UILabel* typeLabel;
@property (weak,nonatomic) IBOutlet UILabel* districtLabel;
@property (weak,nonatomic) IBOutlet UILabel* lengthLabel;
@property (weak,nonatomic) IBOutlet UILabel* startCoordLatLabel;
@property (weak,nonatomic) IBOutlet UILabel* startCoordLongLabel;
@property (weak,nonatomic) IBOutlet UILabel* gradeLabel;
@property (weak,nonatomic) IBOutlet UILabel* ratingLabel;
@property (weak,nonatomic) IBOutlet UILabel* versionLabel;
@property (weak,nonatomic) IBOutlet UILabel* IDLabel;


@end
