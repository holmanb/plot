CC = gcc
CC_FLAGS = -g -pedantic -Wall -Wextra -Wstrict-prototypes -Wmissing-prototypes -Wshadow -Wconversion -Wreturn-type -lm -fstack-protector-strong -Wformat -Werror=format-security -fPIE -fstack-usage
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
	seq 1 500 | shuf |  ./$(EXE) -f  -b 1:2048

.PHONY: check
check:
	seq 500 | shuf > /tmp/tmp.42
	valgrind --leak-check=yes --track-origins=yes --max-stackframe=4343808 ./$(EXE) -f -b 0:512 -i /tmp/tmp.42

.PHONY: check
gdb:
	seq 500 | shuf > /tmp/tmp.42
	gdb  --args $(EXE)  -f -b 0:512 -i /tmp/tmp.42

