//-----------------------------------------------------------------------------
//  Basler pylon SDK
//  Copyright (c) 2008-2021 Basler AG
//  http://www.baslerweb.com
//  Author:  JS
//-----------------------------------------------------------------------------
/*!
\file
\brief  Master include for the PylonUtility library
*/

#ifndef PYLONUTILITIESINCLUDES_H_INCLUDED__
#define PYLONUTILITIESINCLUDES_H_INCLUDED__

#include "Platform.h"
#include "PylonUtility.h"
#include "PylonImage.h"
#include "ImageDecompressor.h"
#include "ImageFormatConverter.h"
#include "FeaturePersistence.h"
#include "ImagePersistence.h"
#if defined(PYLON_WIN_BUILD)
// windows only headers
#    include "PylonBitmapImage.h"
#    include "AviWriter.h"
#endif
#include "VideoWriter.h"

#if defined (PYLON_WIN_BUILD) && !defined (PYLON_NO_AUTO_IMPLIB)
#    include "PylonLinkage.h"
#    pragma comment(lib, PYLON_LIB_NAME( "PylonUtility" ))
#endif

#endif
