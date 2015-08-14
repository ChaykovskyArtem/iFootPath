//
//  ACWalk.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 05.07.15.
//
//

#import "ACWalk.h"

@implementation ACWalk
static NSString* thumbsImageURL = @"http://www.ifootpath.com/upload/thumbs/";
static NSString* fullImageURL = @"http://www.ifootpath.com/upload/";



- (ACWalk*) initWithResponse:(id) response {
    self = [super init];
    if (self) {
        self.walkCountry = [response objectForKey:@"walkCounty"];
        self.walkDescription = [response objectForKey:@"walkDescription"];
        self.walkDistrict = [response objectForKey:@"walkDistrict"];
        self.walkGrade = [response objectForKey:@"walkGrade"];
        self.walkIcon = [self iconImageFromURL:[response objectForKey:@"walkIcon"]];
        self.walkID = [response objectForKey:@"walkID"];
        self.walkIllustration = [self photoImageFromURL:[response objectForKey:@"walkIllustration"]];
        self.walkLength = [response objectForKey:@"walkLength"];
        self.walkPhoto = [self photoImageFromURL:[response objectForKey:@"walkPhoto"]];
        self.walkPublished = [response objectForKey:@"walkPublished"];
        self.walkRating = [response objectForKey:@"walkRating"];
        self.walkSegments = [response objectForKey:@"walkSegments"];
        self.walkStartCoordLat = [response objectForKey:@"walkStartCoordLat"];
        self.walkStartCoordLong = [response objectForKey:@"walkStartCoordLong"];
        self.walkTitle = [response objectForKey:@"walkTitle"];
        self.walkType = [response objectForKey:@"walkType"];
        self.walkVersion = [response objectForKey:@"walkVersion"];
        self.numsegs = [response objectForKey:@"numsegs"];
    }
    return self;
}


-(NSString*) photoImageFromURL:(NSString*)URL {
     NSString* imageString = [fullImageURL stringByAppendingString:URL];
    return imageString;
}
-(NSString*) iconImageFromURL:(NSString*)URL {
 NSString* imageString = [thumbsImageURL stringByAppendingString:URL];
    return imageString;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_walkCountry forKey:@"walkCountry"];
    [encoder encodeObject:_walkDescription forKey:@"walkDescription"];
    [encoder encodeObject:_walkDistrict forKey:@"walkDistrict"];
    [encoder encodeObject:_walkGrade forKey:@"walkGrade"];
    [encoder encodeObject:_walkIcon forKey:@"walkIcon"];
    [encoder encodeObject:_walkID forKey:@"walkID"];
    [encoder encodeObject:_walkIllustration forKey:@"walkIllustration"];
    [encoder encodeObject:_walkLength forKey:@"walkLength"];
    [encoder encodeObject:_walkPhoto forKey:@"walkPhoto"];
    [encoder encodeObject:_walkPublished forKey:@"walkPublished"];
    [encoder encodeObject:_walkRating forKey:@"walkRating"];
    [encoder encodeObject:_walkSegments forKey:@"walkSegments"];
    [encoder encodeObject:_walkStartCoordLat forKey:@"walkStartCoordLat"];
    [encoder encodeObject:_walkStartCoordLong forKey:@"walkStartCoordLong"];
    [encoder encodeObject:_walkTitle forKey:@"walkTitle"];
    [encoder encodeObject:_walkType forKey:@"walkType"];
    [encoder encodeObject:_walkVersion forKey:@"walkVersion"];
    [encoder encodeObject:_numsegs forKey:@"numsegs"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self.walkCountry = [aDecoder decodeObjectForKey:@"walkCountry"];
    self.walkDescription = [aDecoder decodeObjectForKey:@"walkDescription"];
    self.walkDistrict = [aDecoder decodeObjectForKey:@"walkDistrict"];
    self.walkGrade = [aDecoder decodeObjectForKey:@"walkGrade"];
    self.walkIcon = [aDecoder decodeObjectForKey:@"walkIcon"];
    self.walkID = [aDecoder decodeObjectForKey:@"walkID"];
    self.walkIllustration = [aDecoder decodeObjectForKey:@"walkIllustration"];
    self.walkPhoto = [aDecoder decodeObjectForKey:@"walkPhoto"];
    self.walkPublished = [aDecoder decodeObjectForKey:@"walkPublished"];
    self.walkRating = [aDecoder decodeObjectForKey:@"walkRating"];
    self.walkSegments = [aDecoder decodeObjectForKey:@"walkSegments"];
    self.walkStartCoordLat = [aDecoder decodeObjectForKey:@"walkStartCoordLat"];
    self.walkStartCoordLong = [aDecoder decodeObjectForKey:@"walkStartCoordLong"];
    self.walkTitle = [aDecoder decodeObjectForKey:@"walkTitle"];
    self.walkType = [aDecoder decodeObjectForKey:@"walkType"];
    self.walkVersion = [aDecoder decodeObjectForKey:@"walkVersion"];
    self.numsegs = [aDecoder decodeObjectForKey:@"numsegs"];
    
    return self;
}




- (void) getImageFromServerWithUrl:(NSString*) url completionBlock: (void(^)(UIImage* image, NSError* error)) block {
    
    SDWebImageManager *webManager = [SDWebImageManager sharedManager];
    
    [webManager downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageHighPriority progress:
     ^(NSInteger receivedSize, NSInteger expectedSize) {
         
    }
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                               
                               if (image) {
                                   block(image,nil);
                               }
                               
                               if (error) {
                                   block(nil,error);
                               }
                        }
     ];
}




@end
