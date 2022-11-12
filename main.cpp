#include <iostream>

#include "base/Point.h"
#include "data/Vector.h"

int main() {
    base::Point pointX, pointY, pointZ;
    pointX.setValue(1.23);
    pointY.setValue(2.34);
    pointZ.setValue(3.45);

    data::Vector vector;
    vector.setX(pointX);
    vector.setY(pointY);
    vector.setZ(pointZ);

    auto x = vector.getX().getValue();
    auto y = vector.getY().getValue();
    auto z = vector.getZ().getValue();

    std::cout << "Demo Bazel -> zSerio generator" << std::endl;
    std::cout << "Vector X=" << x << ", Y=" << y << ", Z=" << z << std::endl;

    return 0;
}
