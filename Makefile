export OS

system:
	@make -C ./c
	@make -C ./lib
	@make -C ./basic/x86_64/int
	@make -C ./basic/x86_64/pic
	@make -C ./basic/x86_64/io
	@make -C ./basic/x86_64/boot
	@make -C ./basic/x86_64/lib
	@make -C ./kernel
	@make -C ./image
	@echo "comple ok"
