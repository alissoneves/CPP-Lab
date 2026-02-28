cmake_minimum_required(VERSION 3.28)
project(cpp_lab VERSION 1.0 LANGUAGES CXX)

# -----------------------------
# Configurações do compilador
# -----------------------------
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# -----------------------------
# Dependências (Conan)
# -----------------------------
find_package(fmt REQUIRED)
find_package(GTest REQUIRED)

# -----------------------------
# Executável principal
# -----------------------------
add_executable(cpp_lab
	    src/main.cpp
    )

    target_link_libraries(cpp_lab
	        PRIVATE
		    fmt::fmt
	    )

	    # =============================
	    # TESTES (sempre no final)
	    # =============================

	    enable_testing()

	    add_executable(cpp_lab_tests
		        tests/test_main.cpp
		)

		target_link_libraries(cpp_lab_tests
			    PRIVATE
			        GTest::gtest_main
			)

			include(GoogleTest)
			gtest_discover_tests(cpp_lab_tests)

