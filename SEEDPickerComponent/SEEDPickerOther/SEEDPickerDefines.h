//
//  SEEDPickerDefines.h
//  driver
//
//  Created by liangbing on 2019/7/29.
//  Copyright © 2019 1hai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EHIDateComponentType) {
    EHIDateComponentTypeYMDHMS    = 0,  //  yyyy-MM-dd HH:mm:ss
    EHIDateComponentTypeYMDHM      ,  //  yyyy-MM-dd HH:mm
    EHIDateComponentTypeYMDH ,       //  yyyy-MM-dd HH
    EHIDateComponentTypeYMD  ,     //  yyyy-MM-dd
    EHIDateComponentTypeMDHM ,   //  MM-dd HH:mm
    EHIDateComponentTypeHM  ,   //  HH:mm
    EHIDateComponentTypeYM,   //  yyyy-MM
    EHIDateComponentTypeY , //  yyyy
};

NS_ASSUME_NONNULL_END
