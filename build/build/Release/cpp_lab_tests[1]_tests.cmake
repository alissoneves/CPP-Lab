add_test([=[MathTest.BasicAssertion]=]  /home/alissoneves/cpp-lab/build/build/Release/cpp_lab_tests [==[--gtest_filter=MathTest.BasicAssertion]==] --gtest_also_run_disabled_tests)
set_tests_properties([=[MathTest.BasicAssertion]=]  PROPERTIES WORKING_DIRECTORY /home/alissoneves/cpp-lab/build/build/Release SKIP_REGULAR_EXPRESSION [==[\[  SKIPPED \]]==])
set(  cpp_lab_tests_TESTS MathTest.BasicAssertion)
