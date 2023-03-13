# Compiler
CC = g++

# Project Name
PROJECT = opencvtest

# Source Files (main.cpp)
SRC = main.cpp

# OpenCV Libraries (pkg-config)
LIBS = `pkg-config --cflags --libs opencv4`

# Compile and Link
$(PROJECT): $(SRC)
	$(CC) -o $(PROJECT) $(SRC) $(LIBS)