//-----------------------------------------------------------------------------
//  (c) 2006 by Basler Vision Technologies
//  Section: Vision Components
//  Project: GenApi
//  Author:  Fritz Dierks
//  $Header$
//
//  License: This file is published under the license of the EMVA GenICam  Standard Group.
//  A text file describing the legal terms is included in  your installation as 'GenICam_license.pdf'.
//  If for some reason you are missing  this file please contact the EMVA or visit the website
//  (http://www.genicam.org) for a full copy.
//
//  THIS SOFTWARE IS PROVIDED BY THE EMVA GENICAM STANDARD GROUP "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE EMVA GENICAM STANDARD  GROUP
//  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,  SPECIAL,
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT  LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  THEORY OF LIABILITY,
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT  (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE  OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//-----------------------------------------------------------------------------
/*!
\file
\brief    Main include file for using GenApi with smart pointers
\ingroup GenApi_PublicInterface
*/

#ifndef GENAPI_GENAPI_H
#define GENAPI_GENAPI_H

#include "GCBase.h"
#include "GCUtilities.h"
#include "GenApiDll.h"
//#include "impl/Log.h"
#include "Pointer.h"
#include "IBase.h"
#include "INode.h"
#include "IValue.h"
#include "ICategory.h"
#include "IInteger.h"
#include "IFloat.h"
#include "IRegister.h"
#include "IEnumeration.h"
#include "IEnumEntry.h"
#include "IBoolean.h"
#include "IPort.h"
#include "IPortRecorder.h"
#include "IPortConstruct.h"
#include "IChunkPort.h"
#include "IString.h"
#include "INodeMap.h"
#include "IDestroy.h"
#include "IDeviceInfo.h"
#include "ISelector.h"
#include "ICommand.h"
#include "IUserData.h"
#include "NodeMapRef.h"
#include "NodeCallback.h"
#include "Persistence.h"
#include "StructPort.h"
#include "SelectorSet.h"

#if defined (_MSC_VER)
#   include "GenApiLinkage.h"
#endif

#endif
