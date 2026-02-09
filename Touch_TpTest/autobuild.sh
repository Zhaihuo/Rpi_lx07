rm -rf build
mkdir build
cd build
if [ $1 == "arm" ]
	then cmake -DCMAKE_TOOLCHAIN_FILE=../toolchain.cmake .. 
elif [ $1 == "x86" ]
	then cmake -DCMAKE_TOOLCHAIN_FILE=../x86-toolchain.cmake .. 
fi
make -j8
cd ..
