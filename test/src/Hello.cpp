#include <gtest/gtest.h>

#include "cocodingcpp/Hello.h"

TEST(TmpAddTest, CheckValues)
{
    ASSERT_EQ(Hello::add(1, 2), 3);
    EXPECT_TRUE(true);
}

int main(int argc, char **argv)
{
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
