//
//  WalksEntity.h
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 14.07.15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ACWalk.h"


@interface WalksEntity : NSManagedObject

@property (nonatomic, retain) NSString * numsegs;
@property (nonatomic, retain) NSString * walkCountry;
@property (nonatomic, retain) NSString * walkDescription;
@property (nonatomic, retain) NSString * walkDistrict;
@property (nonatomic, retain) NSString * walkGrade;
@property (nonatomic, retain) NSString * walkIcon;
@property (nonatomic, retain) NSString * walkID;
@property (nonatomic, retain) NSString * walkIllustration;
@property (nonatomic, retain) NSString * walkLength;
@property (nonatomic, retain) NSString * walkPhoto;
@property (nonatomic, retain) NSString * walkPublished;
@property (nonatomic, retain) NSString * walkRating;
@property (nonatomic, retain) NSString * walkSegments;
@property (nonatomic, retain) NSString * walkStartCoordLat;
@property (nonatomic, retain) NSString * walkStartCoordLong;
@property (nonatomic, retain) NSString * walkTitle;
@property (nonatomic, retain) NSString * walkType;
@property (nonatomic, retain) NSString * walkVersion;



-(void) initWithModel:(ACWalk*) walk;


@end
