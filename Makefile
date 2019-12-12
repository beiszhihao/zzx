export OS

system:
	@make -C ./hand
	@make -C ./lib
	@make -C ./test
	@make -C ./text
	@make -C ./c
	@make -C ./kernel OS=macos
	@make -C ./image
	@echo "comple ok"
