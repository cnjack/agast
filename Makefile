# Minimalistic Makefile for the AGAST C++ demo package
# author: Elmar Mair
# date: 12/2010 
# license: BSD v3

####################################################
# please adapt following lines to your environment # 
####################################################
OPENCV_INCLUDE_PATH = /usr/local/include/opencv
OPENCV_LIBRARY_PATH = /usr/lib

########################################################
# the following lines should not be edited by the user #
########################################################
CXX = g++
PROG = demo
OBJ = AstDetector.o agast5_8.o agast5_8_nms.o agast7_12s.o agast7_12s_nms.o agast7_12d.o agast7_12d_nms.o oast9_16.o oast9_16_nms.o nonMaximumSuppression.o

GENERAL_FLAGS = -O3 -pedantic -Wall -Wextra 
CXXFLAGS += $(GENERAL_FLAGS) -ansi -DHAVE_OPENCV -I$(OPENCV_INCLUDE_PATH)
LDFLAGS += -L$(OPENCV_LIBRARY_PATH) -lcxcore -lcv -lhighgui

all: $(PROG)

$(PROG) : $(PROG).cc $(OBJ)
	$(CXX) $(CXXFLAGS) $(PROG).cc $(LDFLAGS) $(OBJ) -o $@
	
%.o : %.cc
	$(CXX) $(CXXFLAGS) -c $<

clean:
	-rm *.o $(PROG)

cleanCMake:
	-rm -rf CMakeFiles
	-rm cmake_install.cmake
	-rm CMakeCache.txt
	-rm Makefile
	ln -s Makefile.linux Makefile
