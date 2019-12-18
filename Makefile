export OS

system:
	@make -C ./hand
	@make -C ./lib
	@make -C ./test
	@make -C ./text
	@make -C ./c
	@make -C ./int
	@make -C ./pic
	@make -C ./io
	@make -C ./kernel
	@make -C ./image
	@echo "comple ok"
