CC = gcc
CC_FLAGS = -g -pedantic -Wall -Wextra -Wstrict-prototypes -Wmissing-prototypes -Wshadow  -Wreturn-type -lm -fstack-protector-strong -Wformat -Werror=format-security -fPIE -fstack-usage #-Wconversion
SHARED_FLAGS = -shared
SUBDIRS = deps/plot/src


EXE = plot
SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)


all: $(OBJ) $(EXE)
.PHONY : all

.PHONY: $(OBJ)
$(OBJ): %.o: %.c
	$(CC) $(CC_FLAGS) $(SHARED_FLAGS) -c $< -o $@ 


.PHONY: $(EXE)
$(EXE): $(OBJ) 
	$(CC) $(CC_FLAGS) $(OBJ) -o $(EXE)


.PHONY: clean 
clean:
		-rm -f $(EXE) $(OBJ) $(SHARED) 

.PHONY: test
test:
	seq 1 500 | shuf |  ./$(EXE) -f  -b 1:512

.PHONY: test_stress
test_stress:
	while [ 1 == 1 ];do awk 'BEGIN{srand();printf("%d",512*rand())}'; sleep .01; done | ./plot -f

.PHONY: check
check:
	seq 500 | shuf > /tmp/tmp.42
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --main-stacksize=80000000 --max-stackframe=4343808 ./$(EXE) -f -b 0:512 -i /tmp/tmp.42

.PHONY: check
gdb:
	seq 500 | shuf > /tmp/tmp.42
	gdb  --args $(EXE)  -b 0:512 -i /tmp/tmp.42

