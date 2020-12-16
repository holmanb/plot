CC = gcc
CC_FLAGS = -g -pedantic -Wall -Wextra -Wstrict-prototypes -Wmissing-prototypes -Wshadow -Wconversion -Wreturn-type -lm
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
		valgrind --leak-check=yes --track-origins=yes ./$(EXE)

.PHONY: check
gdb:
		gdb $(EXE)

