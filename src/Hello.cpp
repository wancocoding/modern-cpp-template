
#include "Hello.h"
#include <fmt/core.h>
#include <iostream>

using namespace std;

void Hello::print() { std::cout << "Hello Headers!" << std::endl; }

void Hello::printf() { fmt::print("Hello, {}!\n", "Cocoding"); }

int Hello::add(int a, int b) { return a + b; }
