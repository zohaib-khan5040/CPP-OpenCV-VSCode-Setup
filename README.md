# How to setup an OpenCV Project on VS Code

Click [here](https://medium.com/analytics-vidhya/how-to-install-opencv-for-visual-studio-code-using-ubuntu-os-9398b2f32d53) for the reference article.

## Part 1: Installing OpenCV

Follow up until the end of "Part 1" in the above article.

The end goal should be to run the following command on the terminal and see an output.

```
$ pkg-config -modversion opencv4
```

> Be careful in regards to writing `opencv` and `opencv4` (or something similar) here. This is important for a later step.

## Part 2: Configuration with Visual Studio Code

### Step 1. Setup a project

Create a new project and open it up in VS Code. The directory should look something like:

```
project-name
    main.cpp
    dog.jpeg
```

Copy the code from this `main.cpp` into yours.

### Step 2. CPP Properties

1. Hit `Ctrl+Shift+P` to open up the *command palet*.
2. Select `C/C++: Edit Configurations (JSON)`.
3. Find the `c_cpp_properties.json` file.

Here, the only thing is to add in the following line to the `includePath` property:
```
"/usr/include/opencv4"
```

> The tutorial does this slightly differently. Ignore the `**` in that file for now.

Now that property should be looking like:
```json
"includePath": [
                "${workspaceFolder}/**",
                "/usr/include/opencv4"
],
```

Now we've configured VS Code to find the libraries we need. You may notice a small `.vscode` directory in your project structure now.


### Step 3. Setting up the Makefile

Now we focus on creating a Makefile. This is what will set some ground rules for how to *run our project*, including instructions on compiling and dealing with other dependencies (like OpenCV).

1. Create a `Makefile` in the same directory as your `main.cpp`. The directory should look like:
```
project-name
    main.cpp
    dog.jpeg
    Makefile
```

2. Fill in the Makefile:
```make
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
```

The thing of importance here is the `SRC` variable, and the `LIBS` variable.
* `SRC` is the name of the file to run, that will form the executable. In this case, it's `main.cpp`.
* `LIBS` is assigned the command that will configure the packahes for us. In this case, it is just `opencv4`.

### Step 4: Running the Project

Just run `make` in your terminal. This will make use of your Makefile, and generate an executable that you can run.

The executable will have the same name as the `PROJECT` property, and can be run as `./opencvtest` for example.

## Troubleshooting

If you run into an error regarding the `LIBS` property, the first thing to try is to replace `opencv4` with `opencv` or whatever was working when you first ran 
```
$ pkg-config -modversion opencv4
```

If there is another issue, you can try to uncomment the line at the top of `main.cpp` here, i.e. try to run 
```
#include <opencv2/highgui.hpp>
```
at the top rather than
```
#include <opencv2/highgui/highgui.hpp>
```

This goes back to following this README, or the article where the author mentioned writing `/usr/local/include/opencv4/**` in the JSON file, whereas we took out the two `*`s at the end.