//
//  ACDetailsViewController.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 06.07.15.
//
//

#import "ACDetailsViewController.h"
#import "ACWalkDetailsCell.h"
#import "UIImageView+AFNetworking.h"
#import "ACCoreDataManager.h"
#import "ACDescriptionCell.h"
#import "ACMainViewContoller.h"
#import "ACDetailsEditCell.h"
#import "ACFullScreenImageController.h"
#import <CoreData/CoreData.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface ACDetailsViewController ()



@end

@implementation ACDetailsViewController

static NSString* walkPhotoUrl = @"http://www.ifootpath.com/upload/";


- (void)viewDidLoad {
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                          target:self
                                                                          action:@selector(deleteObjectFromCoreData)];
    [self.navigationItem setRightBarButtonItem:item animated:NO];
    
    self.navigationItem.title = self.walkEntity.walkTitle;
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"imageCell";
    static NSString* identifier1 = @"descriptionCell";
    static NSString* identifier2 = @"detailsEditCell";
    
    if ( indexPath.row == 0 || indexPath.row == 2) {
        
    ACWalkDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ACWalkDetailsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
        if (indexPath.row == 0) {

        NSURL* url = [NSURL URLWithString:self.walkEntity.walkPhoto];
        [cell.walkPhoto setImageWithURL:url];
            
        return cell;
}
        if (indexPath.row == 2) {
    
                NSURL* url = [NSURL URLWithString:self.walkEntity.walkIllustration];
                [cell.walkPhoto setImageWithURL:url];
            
             if ([self.walkEntity.walkIllustration hasSuffix:@"/upload/"]) {
                
                UIImage* image = [UIImage imageNamed:@"No_Image"];
                [cell.walkPhoto setImage:image];
            }
                return cell;
        }
}
    if ( indexPath.row == 1) {
        
        ACDescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        
        if (!cell) {
            cell = [[ACDescriptionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier1];
        }
        cell.textView.text = self.walkEntity.walkDescription;
        cell.textView.editable = YES;
        return cell;
    }
        
    if (indexPath.row == 3) {
        
            ACDetailsEditCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            if (!cell) {
            cell = [[ACDetailsEditCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier2];
            }
            cell.titleLabel.text = @"Title:";
            cell.titleTextField.text = self.walkEntity.walkTitle;
            
            cell.countryLabel.text = @"Country:";
            cell.countryTextField.text = self.walkEntity.walkCountry;
            
            cell.typeLabel.text = @"Type:";
            cell.typeTextField.text = self.walkEntity.walkType;
            
            cell.districtLabel.text = @"District:";
            cell.districtTextField.text = self.walkEntity.walkDistrict;
            
            cell.lengthLabel.text = @"Length:";
            cell.lengthTextField.text = self.walkEntity.walkLength;
            
            cell.startCoordLatLabel.text = @"Latitude:";
            cell.startCoordLatTextField.text = self.walkEntity.walkStartCoordLat;
            
            cell.startCoordLongLabel.text = @"Longitude:";
            cell.startCoordLongTextField.text = self.walkEntity.walkStartCoordLong;
            
            cell.gradeLabel.text = @"Grade:";
            cell.gradeTextField.text = self.walkEntity.walkGrade;
            
            cell.ratingLabel.text = @"Rating:";
            
            NSString* rating = self.walkEntity.walkRating;
            if ([rating length] > 3) {
                rating = [rating substringToIndex:3];
                if ([rating hasSuffix:@"0"]) {
                    rating = [rating substringToIndex:1];
                }
            }
            
            cell.ratingTextField.text = rating;
            
            cell.versionLabel.text = @"Version:";
            cell.versionField.text = self.walkEntity.walkVersion;
            
            cell.IDLabel.text = @"ID:";
            cell.IDField.text = self.walkEntity.walkID;
            
            return cell;
        }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return 500;
    } else
    return 250;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ACFullScreenImageController* viewController = [self.storyboard instantiateViewControllerWithIdentifier: @"identifier1"];;
        
        viewController.imageString = self.walkEntity.walkPhoto;
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
    if (indexPath.row == 2) {
        ACFullScreenImageController* viewController = [self.storyboard instantiateViewControllerWithIdentifier: @"identifier1"];;
        viewController.imageString = self.walkEntity.walkIllustration;
        [self presentViewController:viewController animated:YES completion:nil];
    }
}


#pragma mark - Actions

-(void) deleteObjectFromCoreData {
    NSManagedObject* object = self.walkEntity;
    [[ACCoreDataManager sharedManager] deleteObject:object];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)endEditingText {
    [self.view endEditing:YES];
}


#pragma mark - UITextViewDelegate

-(void) textViewDidBeginEditing:(UITextView *)textView {
 
    self.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(endEditingText)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
}


- (void)textViewDidEndEditing:(UITextView *)textView {
   
    self.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                          target:self
                                                                          action:@selector(deleteObjectFromCoreData)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
    [self changeValueOfObjectWithText:textView.text forKey:@"walkDescription"];
}


 
#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(endEditingText)];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {

        if ([textField.restorationIdentifier  isEqual: @"titleTextField"]) {
        if ([textField.text length] == 0) {
            [self changeValueOfObjectWithText:@"unknown title" forKey:@"walkTitle"];
            self.navigationItem.title = @"unknown title";
        }else{
        [self changeValueOfObjectWithText:textField.text forKey:@"walkTitle"];
            self.navigationItem.title = textField.text;
        }
    }
    if ([textField.restorationIdentifier  isEqual: @"countryTextField"]) {
        [self changeValueOfObjectWithText:textField.text forKey:@"walkCountry"];
    }
    if ([textField.restorationIdentifier  isEqual: @"typeTextField"]) {
        [self changeValueOfObjectWithText:textField.text forKey:@"walkType"];
    }
    if ([textField.restorationIdentifier  isEqual: @"districtTextField"]) {
        [self changeValueOfObjectWithText:textField.text forKey:@"walkDistrict"];
    }
    if ([textField.restorationIdentifier  isEqual: @"lengthTextField"]) {
        [self changeValueOfObjectWithText:textField.text forKey:@"walkLength"];
    }
    if ([textField.restorationIdentifier  isEqual: @"startCoordLatTextField"]) {
        
        [self changeValueOfObjectWithText:textField.text forKey:@"walkStartCoordLat"];
    }
    if ([textField.restorationIdentifier  isEqual: @"startCoordLongTextField"]) {
        [self changeValueOfObjectWithText:textField.text forKey:@"walkStartCoordLong"];
    }
    if ([textField.restorationIdentifier  isEqual: @"gradeTextField"]) {
        [self changeValueOfObjectWithText:textField.text forKey:@"walkGrade"];
    }
    if ([textField.restorationIdentifier  isEqual: @"ratingTextField"]) {
        [self changeValueOfObjectWithText:textField.text forKey:@"walkRating"];
    }
    if ([textField.restorationIdentifier  isEqual: @"versionField"]) {
        [self changeValueOfObjectWithText:textField.text forKey:@"walkVersion"];
    }
    if ([textField.restorationIdentifier  isEqual: @"IDField"]) {
        [self changeValueOfObjectWithText:textField.text forKey:@"walkID"];
    }
    
    self.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                              target:self
                                                                              action:@selector(deleteObjectFromCoreData)];
        [self.navigationItem setRightBarButtonItem:item animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - ChangeValue


-(void) changeValueOfObjectWithText:(NSString*) text forKey:(NSString*) key {
 
    [[ACCoreDataManager sharedManager] changeObjectInCoreData:self.walkEntity withText:text forKey:key];
}

@end
