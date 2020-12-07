My Cpp Bootstrap
======

## Features

* modern cpp
* cmake project
* unit test with google test
* code format with `clang-format`
* package management by `conan` and `CPM`
* separation of library and cmd code
* CI integration(github action)
* Coverage with codecov.io



## TODO

* [ ] generate docs with doxygen


## Build

```sh
cmake -Bbuild -DCMAKE_BUILD_TYPE=Release
cmake --build build -j4
```

## Test

```
cmake -Bbuild -DCMAKE_BUILD_TYPE=Debug
cmake --build build -j4
cd build
ctest --build-config Debug
```


