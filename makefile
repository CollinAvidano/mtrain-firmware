
define cmake_build_target
	mkdir -p build
	cd build && cmake -DCMAKE_TOOLCHAIN_FILE=arm_toolchain.cmake --target $1 .. && make $1
endef

all:
	$(call cmake_build_target, all)

C_FIRMWARE_TESTS = blink gpio blink_interrupt flash usb_serial spi
CPP_FIRMWARE_TESTS = blink gpio blink_interrupt spi

$(C_FIRMWARE_TESTS:%=test-%-c):
	$(call cmake_build_target, $(@F))
$(C_FIRMWARE_TESTS:%=test-%-c-prog):
	$(call cmake_build_target, $(@F))

$(CPP_FIRMWARE_TESTS:%=test-%):
	$(call cmake_build_target, $(@F))
$(CPP_FIRMWARE_TESTS:%=test-%-prog):
	$(call cmake_build_target, $(@F))

clean:
	rm -rf build
