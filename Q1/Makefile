compile1:
# 	Compile your code for first part here
	nasm booter_2019459.asm -o booter.o

run1: compile1
	qemu-system-x86_64 -fda booter.o
# 	 Execute part 1 here

compile2:
# 	Compile your code for second part here

run2: compile2
#	Execute part 2 here

clear:
	rm booter.bin