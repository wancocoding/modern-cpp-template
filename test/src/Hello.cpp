#include <gtest/gtest.h>

#include "Hello.h"

TEST(TmpAddTest, CheckValues)
{
    Hello hi;
    hi.print();
    hi.printf();
    ASSERT_EQ(hi.add(1, 2), 3);
    EXPECT_TRUE(true);
}

int main(int argc, char **argv)
{
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
