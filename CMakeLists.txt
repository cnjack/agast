# Configuration script for the project agastDemo
# Author: Juergen Wohlfeil and Elmar Mair
# Execute cmake on this directory to (re)generate the Projectfiles/Makefiles
#
# It supports the inclusion of OpenCV 2.1, required for the demo program.
# In this case execute cmake with the arguments -D OpenCV_DIR=\"C:/Dir/To/OpenCV\"
# 

CMAKE_MINIMUM_REQUIRED(VERSION 2.6.4)

set(PROJECTNAME "agastDemo")
PROJECT(${PROJECTNAME} CXX C)

IF ("${OpenCV_DIR}" EQUAL "")
    set(OpenCV_DIR $ENV{OpenCV_DIR})
ENDIF() 

# Include OpenCV
IF ("${OpenCV_DIR}" EQUAL "")
	message(STATUS "NOTE: The variable OpenCV_DIR isn't defined. If you want to use CMake you have to define OpenCV_DIR it by adding -D OpenCV_DIR=\"C:/Dir/To/OpenCV\" as cmake argument")
ELSE()
	message(STATUS "OpenCV_DIR = ${OpenCV_DIR}")

	IF (NOT EXISTS "${OpenCV_DIR}")
		message(FATAL_ERROR "The variable OpenCV_DIR must be the OpenCV directory, but points to the non-existent directory ${OpenCV_DIR}")
	ENDIF()
	
	IF(MSVC) # Microsoft Visual Studio specific configuration
		include_directories("${OpenCV_DIR}/include/opencv")
		link_directories("${OpenCV_DIR}/lib")
		set(LIBS cxcore210 cvaux210 highgui210 cv210) # To be able to call target_link_libraries(${PROJECTNAME} ${LIBS}) after adding the executable
	ELSE()	# GNU specific configuration
		include_directories("${OpenCV_DIR}/include/opencv")
		link_directories("${OpenCV_DIR}/lib")
		set(LIBS ${OpenCV_DIR}/lib/libcxcore.so.2.1 ${OpenCV_DIR}/lib/libcvaux.so.2.1 ${OpenCV_DIR}/lib/libhighgui.so.2.1 ${OpenCV_DIR}/lib/libcv.so.2.1) # To be able to call target_link_libraries(${PROJECTNAME} ${LIBS}) after adding the executable
	ENDIF()

	add_definitions(-DHAVE_OPENCV)
ENDIF()

IF(MSVC)
	include_directories("./msvc") #Necessary to find stdint if compiling with MSVC
ENDIF()

add_executable (${PROJECTNAME}
	agast5_8.cc
	agast5_8_nms.cc
	agast7_12d.cc
	agast7_12d_nms.cc
	agast7_12s.cc
	agast7_12s_nms.cc
	AstDetector.cc
	nonMaximumSuppression.cc
	oast9_16.cc
	oast9_16_nms.cc
	demo.cc
	agast5_8.h
	agast7_12d.h
	agast7_12s.h
	AstDetector.h
	cvWrapper.h
	oast9_16.h
)

target_link_libraries(${PROJECTNAME} ${LIBS})	# Must be defined after defining executable


