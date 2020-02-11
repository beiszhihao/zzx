export OS

system:
	@make -C ./c
	@make -C ./basic/x86/int
	@make -C ./basic/x86/pic
	@make -C ./basic/x86/io
	@make -C ./basic/x86/boot
	@make -C ./basic/x86/lib
	@make -C ./kernel
	@make -C ./image
	@echo "comple ok"
