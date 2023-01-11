//-----------------------------------------------------------------------------
//  Basler pylon SDK
//  Copyright (c) 2008-2021 Basler AG
//  http://www.baslerweb.com
//  Author:  JS
//-----------------------------------------------------------------------------
/*!
\file
\brief includes specific for the Camera Link transport layer
*/

#ifndef PYLON_CAMERALINK_INCLUDED_INCLUDED__
#define PYLON_CAMERALINK_INCLUDED_INCLUDED__

#if _MSC_VER > 1000
#pragma once
#endif //_MSC_VER > 1000

#include "Platform.h"
#include "StreamGrabberProxy.h"
#include "DeviceClass.h"
#include "cameralink/BaslerCameraLinkDeviceInfo.h"
#include "cameralink/PylonCLSerDeviceInfo.h" // for backward compatibility
#include "cameralink/BaslerCameraLinkCamera.h"

namespace Pylon
{
    const char* const CLSerTransportLayer( "Camera Link" );

    // just use forwards to make generated header PylonCLSerIncludes compilable
    class CBaslerCameraLinkDeviceInfo;
    class CPylonCLSerDevice;

    typedef void CPylonCLSerEventGrabber;
}

#endif // PYLON_CAMERALINK_INCLUDED_INCLUDED__
