//
//  WalksEntity.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 14.07.15.
//
//

#import "WalksEntity.h"


@implementation WalksEntity

@dynamic numsegs;
@dynamic walkCountry;
@dynamic walkDescription;
@dynamic walkDistrict;
@dynamic walkGrade;
@dynamic walkIcon;
@dynamic walkID;
@dynamic walkIllustration;
@dynamic walkLength;
@dynamic walkPhoto;
@dynamic walkPublished;
@dynamic walkRating;
@dynamic walkSegments;
@dynamic walkStartCoordLat;
@dynamic walkStartCoordLong;
@dynamic walkTitle;
@dynamic walkType;
@dynamic walkVersion;


-(void) initWithModel:(ACWalk*) walk {
    
    self.walkCountry = walk.walkCountry;
    self.walkDescription = walk.walkDescription;
    self.walkDistrict = walk.walkDistrict;
    self.walkGrade = walk.walkGrade;
    self.walkIcon = walk.walkIcon;
    self.walkID = walk.walkID;
    self.walkIllustration = walk.walkIllustration;
    self.walkLength = walk.walkLength;
    self.walkPhoto = walk.walkPhoto;
    self.walkPublished = walk.walkPublished;
    self.walkRating = walk.walkRating;
    self.walkStartCoordLat = walk.walkStartCoordLat;
    self.walkStartCoordLong = walk.walkStartCoordLong;
    self.walkTitle = walk.walkTitle;
    self.walkType = walk.walkType;
    self.walkVersion = walk.walkVersion;
}




@end
