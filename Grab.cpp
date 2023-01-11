// Grab.cpp
/*
    Note: Before getting started, Basler recommends reading the "Programmer's Guide" topic
    in the pylon C++ API documentation delivered with pylon.
    If you are upgrading to a higher major version of pylon, Basler also
    strongly recommends reading the "Migrating from Previous Versions" topic in the pylon C++ API documentation.

    This sample illustrates how to grab and process images using the CInstantCamera class.
    The images are grabbed and processed asynchronously, i.e.,
    while the application is processing a buffer, the acquisition of the next buffer is done
    in parallel.

    The CInstantCamera class uses a pool of buffers to retrieve image data
    from the camera device. Once a buffer is filled and ready,
    the buffer can be retrieved from the camera object for processing. The buffer
    and additional image data are collected in a grab result. The grab result is
    held by a smart pointer after retrieval. The buffer is automatically reused
    when explicitly released or when the smart pointer object is destroyed.
*/

// Include files to use the pylon API.
#include "Includes/PylonIncludes.h"
#include "mex.hpp"
#include "mexAdapter.hpp"
#include <stdlib.h>
#include <fstream>
#include <cstdio>

#ifdef PYLON_WIN_BUILD
#    include "Includes/PylonGUI.h"
#endif

// Namespace for using pylon objects.
using namespace Pylon;

// Namespace for using cout.
using namespace std;

// Number of images to be grabbed.
static const uint32_t c_countOfImagesToGrab = 1;

class MexFunction : public matlab::mex::Function {
    public:
        void operator ()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
            Grab();
            Save();
        }
        void Grab( /*int*/ /*argc*/ /*char**/ /*argv*//*[]*/ )
        {
            // Before using any pylon methods, the pylon runtime must be initialized.
            PylonInitialize();
        
            try
            {
                // Create an instant camera object with the camera device found first.
                CInstantCamera camera( CTlFactory::GetInstance().CreateFirstDevice() );
        
                // Print the model name of the camera.
                //cout << "Using device " << camera.GetDeviceInfo().GetModelName() << endl;
        
                // The parameter MaxNumBuffer can be used to control the count of buffers
                // allocated for grabbing. The default value of this parameter is 10.
                camera.MaxNumBuffer = 5;
        
                // Start the grabbing of c_countOfImagesToGrab images.
                // The camera device is parameterized with a default configuration which
                // sets up free-running continuous acquisition.
                camera.StartGrabbing( c_countOfImagesToGrab );
        
                // This smart pointer will receive the grab result data.
                CGrabResultPtr ptrGrabResult;
        
                // Camera.StopGrabbing() is called automatically by the RetrieveResult() method
                // when c_countOfImagesToGrab images have been retrieved.
                while (camera.IsGrabbing())
                {
                    // Wait for an image and then retrieve it. A timeout of 5000 ms is used.
                    camera.RetrieveResult( 5000, ptrGrabResult, TimeoutHandling_ThrowException );
        
                    // Image grabbed successfully?
                    if (ptrGrabResult->GrabSucceeded())
                    {
                        // Access the image data.
                        //cout << "SizeX: " << ptrGrabResult->GetWidth() << endl;
                        //cout << "SizeY: " << ptrGrabResult->GetHeight() << endl;
                        const uint8_t* pImageBuffer = (uint8_t*) ptrGrabResult->GetBuffer();
                        //cout << "Gray value of first pixel: " << (uint32_t) pImageBuffer[0] << endl << endl;
        
        #ifdef PYLON_WIN_BUILD
                        // Display the grabbed image for 5 seconds. 
                        //For debugging uses mainly. Can remove for faster runtime (i.e. in move + image sequence)
                        Pylon::DisplayImage( 1, ptrGrabResult );
                        Sleep(1000);

                        // Save image as a default/buffer .tiff and .bmp file
                        CImagePersistence::Save( ImageFileFormat_Tiff, "ImageFiles/TempImage.tiff", ptrGrabResult );
                        CImagePersistence::Save( ImageFileFormat_Bmp, "ImageFiles/TempImage.bmp", ptrGrabResult );
                                
        #endif
                    }
                    else
                    {
                        cout << "Error: " << std::hex << ptrGrabResult->GetErrorCode() << std::dec << " " << ptrGrabResult->GetErrorDescription() << endl;
                    }
                }
            }

            catch (const GenericException& e)
            {
                // Error handling.
                cerr << "An exception occurred." << endl
                    << e.GetDescription() << endl;
            }
        
            // Releases all pylon resources.
            PylonTerminate();
        }
        void Save() {
            //initialize file saving variables
            int counter = 0;
            string file;
            string f1;
            string f2;
            ifstream f;

            // file extensions
            string tiff = ".tiff";
            string bmp = ".bmp";
            
            // saving as a file with the smallest unused file number within folder ImageFiles
            while (true) {
                file = "ImageFiles/Image";
                string c = to_string(counter);
                file.append(c);
                
                f1 = file + tiff;
                f.open(f1);

                bool f_exists = f.is_open();

                if (f_exists) {
                    counter ++;
                    f.close();
                } else {
                    f.close();
                    break;
                }
            }         
            
            string s1 = file + tiff;
            string s2 = file + bmp;
        
            const char * c1 = s1.c_str();
            const char * c2 = s2.c_str();
                        
            if(rename("ImageFiles/TempImage.tiff", c1) != 0) {
                cout << "Image cannot be renamed: temp file (.tiff) does not exist" << endl;
            } else {
                cout << "Images saved" << endl;
            }
            if(rename("ImageFiles/TempImage.bmp", c2) != 0) {
                cout << "Image.bmp cannot be renamed: temp file (.bmp) does not exist" << endl;
            } else {
                ;
            }
        }
};
