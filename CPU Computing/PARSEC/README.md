Here we introduce how the PARSEC component is compiled and run in our test project. We only list the parts we use. For more information about the function and usage of the PARSEC component, please refer to the [official website]([The PARSEC Benchmark Suite (princeton.edu)](https://parsec.cs.princeton.edu/)) of PARSEC.

The version of PARSEC we are using is 3.0. You can download and unzip the installation package using the following command:

```
wget "http://parsec.cs.princeton.edu/download/3.0/parsec-3.0.tar.gz"
tar -zxvf parsec-3.0.tar.gz
```

Due to the older version of PARSEC, we recommend downgrading the version of gcc and g++ to 4.8 during the compilation process of components. Here we provide the methods we used as a reference:

```
sudo apt-get update
sudo apt-get install gcc-4.8 g++-4.8 -y
```

Next, please downgrade the original versions of gcc and g++. In the testing environment we use, the default version of gcc/g++ is 9

```
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 10
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 10

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 20
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 20
```

Now, you can navigate to the PARSEC folder and try using the provided script to check the installation status of the components.

```
cd parsec-3.0
source env.sh
parsecmgmt -a status
```

Run the script to fix some issues in the PARSEC components and check for dependency packages. Please make sure that the script is located in the same path as the PARSEC folder you extracted.

```
cd ..
sudo ./repair.sh
```

Next, we will start compiling the components. Due to the limitations of TEE's own functions and to maintain consistency between tests among different TEEs, we need to measure the compiled components using direct launch commands. To avoid the impact of TEE initialization (which is present in SGX but not in SEV and CSV), we will use the hooks library provided in PARSEC to output the running time of the components directly.

We need to enable this feature first, which involves some modifications to the PARSEC source files. To simplify the process, please replace the `hooks.c` file used by PARSEC with the one we provided.

```
rm parsec-3.0/pkgs/libs/hooks/src/hooks.c
mv hooks.c parsec-3.0/pkgs/libs/hooks/src/
```

// Comment out lines 102 to 105 in parsec-3.0/pkgs/libs/uptcpip/src/include/sys/bsd__types.h

After that, we can compile the components to be tested.

```
parsecmgmt -a build -c gcc-hooks -p blackscholes canneal fluidanimate freqmine streamcluster bodytrack dedup facesim ferret swaptions 
```

This may take some time. After the compilation is complete, you can use the command mentioned earlier to check the installation status of each component and ensure they are installed correctly.

Now, run the script to extract the component's execution commands from the files and write them into each component's testing script. At this step, you can specify the dataset you want to use, for example:

```
```



