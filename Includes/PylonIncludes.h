//-----------------------------------------------------------------------------
//  Basler pylon SDK
//  Copyright (c) 2008-2021 Basler AG
//  http://www.baslerweb.com
//  Author:  JS
//-----------------------------------------------------------------------------
/*!
\file
\brief  Master include for Pylon
*/

#ifndef PYLONINCLUDES_H_INCLUDED__
#define PYLONINCLUDES_H_INCLUDED__


// PylonPlatform.h must be included before including any GenICam/GenApi header files,
// to ensure that the GENICAM_COMPILER_STR macro used by GenICam/GenApi is set properly
#include "Platform.h"

#include "PylonLinkage.h"

// basic types (from GenICam)
#include "GCTypes.h"
#include "GCString.h"
#include "GCStringVector.h"

// GenICam stuff

#if defined( PYLON_NO_AUTO_IMPLIB )
#   define GENICAM_NO_AUTO_IMPLIB
#   define HAS_DEFINED_GENICAM_NO_AUTO_IMPLIB
#endif

#ifdef PYLON_LINUX_BUILD
#   undef GCC_VERSION
#   define GCC_VERSION (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__)
#   undef GCC_DIAGNOSTIC_AWARE
#   define GCC_DIAGNOSTIC_AWARE          (GCC_VERSION >= 40200)
#   undef GCC_DIAGNOSTIC_PUSH_POP_AWARE
#   define GCC_DIAGNOSTIC_PUSH_POP_AWARE (GCC_VERSION >= 40600)
#else
#   undef GCC_DIAGNOSTIC_AWARE
#   define GCC_DIAGNOSTIC_AWARE 0
#endif

#if GCC_DIAGNOSTIC_AWARE
#   if GCC_DIAGNOSTIC_PUSH_POP_AWARE
#       pragma GCC diagnostic push
#   endif
#   pragma GCC diagnostic ignored "-Wunknown-pragmas"
#   pragma GCC diagnostic ignored "-Wpragmas"   // gcc < 4.6 doesn't know the following pragma
#   pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif

#if defined (PYLON_OSX_BUILD)
#   pragma clang diagnostic push
#   pragma clang diagnostic ignored "-Wunused-variable"
#   pragma clang diagnostic ignored "-Wunknown-pragmas"
#endif

#include "GenApi.h"

#if defined (PYLON_OSX_BUILD)
#   pragma clang diagnostic pop
#endif

#if GCC_DIAGNOSTIC_AWARE
#   if GCC_DIAGNOSTIC_PUSH_POP_AWARE
#       pragma GCC diagnostic pop
#   else
#       pragma GCC diagnostic warning "-Wunknown-pragmas"
#       pragma GCC diagnostic warning "-Wunused-but-set-variable"
#       pragma GCC diagnostic warning "-Wpragmas"   // gcc < 4.6 doesn't know the pragma
#   endif
#endif

#if defined( HAS_DEFINED_GENICAM_NO_AUTO_IMPLIB )
#   undef GENICAM_NO_AUTO_IMPLIB
#   undef HAS_DEFINED_GENICAM_NO_AUTO_IMPLIB
#endif



// basic macros
#include "stdinclude.h"


// init functions
#include "PylonBase.h"
#include "PylonVersionInfo.h"


#include "Info.h"             // IProperties interface and CInfoBase class
#include "TlInfo.h"           // CTlInfo
#include "DeviceClass.h"      // DeviceClass definitions
#include "DeviceInfo.h"       // CDeviceInfo
#include "Container.h"        // DeviceInfoList, TlInfoList
#include "DeviceFactory.h"    // IDeviceFactory
#include "TransportLayer.h"   // ITransportLayer, CTransportLayerBase
#include "TlFactory.h"        // TlFactory

#include "EventAdapter.h"     // IEventAdapter
#include "Callback.h"         // Base_Callback1Body, Callback1, Function_CallbackBody, Member_CallbackBody, make_MemberFunctionCallback
#include "Device.h"           // EDeviceAccessMode, AccessModeSet, IDevice, IPylonDevice, RegisterRemovalCallback

#include "StreamGrabber.h"    // IStreamGrabber

#include "PixelType.h"        // EPixelType, EPixelColorFilter, several helper function for EPixelType
#include "Pixel.h"            // Structs that describe the memory layout of pixel.
#include "PixelTypeMapper.h"  // CPixelTypeMapper, CCameraPixelTypeMapperT template maps device specific pixel formats to pylon pixel types.
#include "Result.h"           // EGrabStatus, EPayloadType, GrabResult, EventResult
#include "PylonDataComponent.h"                   // PylonDataComponent to access for multi-component grab results
#include "PylonDataContainer.h"                   // PylonDataContainer to 


#include "ChunkParser.h"      // IChunkParser, CChunkParser

#include "EventGrabber.h"     // IEventGrabber
#include "EventGrabberProxy.h"// CEventGrabberProxy

#include "NodeMapProxy.h"     // CNodeMapProxy

#include "WaitObject.h"
#include "WaitObjects.h"

#include "AcquireSingleFrameConfiguration.h"      // CAcquireSingleFrameConfiguration
#include "InstantCameraArray.h"                   // CInstantCameraArray, includes CInstantCamera
#include "AcquireContinuousConfiguration.h"       // CAcquireContinuousConfiguration
#include "SoftwareTriggerConfiguration.h"         // CSoftwareTriggerConfiguration

#include "InstantInterface.h"  // CInstantInterface, IInterface

#include "ParameterIncludes.h" // Parameter classes

//////////////////////////////////////////////////////////////////////////////
// add the PylonUntility headers
#ifndef PYLON_NO_UTILITY_INCLUDES
#   include "PylonUtilityIncludes.h"
#endif



//////////////////////////////////////////////////////////////////////////////
// add the pylon libs
#if defined(PYLON_WIN_BUILD)
#   ifndef PYLON_NO_AUTO_IMPLIB
#       pragma comment(lib, PYLON_LIB_NAME( "PylonBase" ))
#   endif

#endif

#include "GenApiDll.h"

#endif //PYLONINCLUDES_H_INCLUDED__
