//
//  ACWalk.h
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SDWebImageManager.h>

@interface ACWalk : NSObject  <NSCoding>

- (ACWalk*) initWithResponse:(id) response;


- (void) getImageFromServerWithUrl:(NSString*) url completionBlock: (void(^)(UIImage* image, NSError* error)) block;


@property (strong, nonatomic) NSString* walkCountry;
@property (strong, nonatomic) NSString* walkDescription;
@property (strong, nonatomic) NSString* walkDistrict;
@property (strong, nonatomic) NSString* walkGrade;
@property (strong, nonatomic) NSString* walkIcon;
@property (strong, nonatomic) NSString* walkID;
@property (strong, nonatomic) NSString* walkIllustration;
@property (strong, nonatomic) NSString* walkLength;
@property (strong, nonatomic) NSString* walkPhoto;
@property (strong, nonatomic) NSString* walkPublished;
@property (strong, nonatomic) NSString* walkRating;
@property (strong, nonatomic) NSString* walkSegments;
@property (strong, nonatomic) NSString* walkStartCoordLat;
@property (strong, nonatomic) NSString* walkStartCoordLong;
@property (strong, nonatomic) NSString* walkTitle;
@property (strong, nonatomic) NSString* walkType;
@property (strong, nonatomic) NSString* walkVersion;
@property (strong, nonatomic) NSString* numsegs;

@end
