ifndef HSA_RUNTIME_PATH
	HSA_RUNTIME_PATH=/opt/hsa
endif

TEST_NAME=test1
LFLAGS= -g  -Wl,--unresolved-symbols=ignore-in-shared-libs
INCS = -I $(HSA_RUNTIME_PATH)/include
C_FILES := $(wildcard *.c)
OBJ_FILES := $(addprefix obj/, $(notdir $(C_FILES:.c=.o)))

all: $(TEST_NAME) $(TEST_NAME).brig

$(TEST_NAME): $(OBJ_FILES) $(COMMON_OBJ_FILES)
	$(CC) $(LFLAGS) $(OBJ_FILES) -L$(HSA_RUNTIME_PATH)/lib -lhsa-runtime64 -o $(TEST_NAME)

$(TEST_NAME).brig :
	cloc.sh $(TEST_NAME).cl

obj/%.o: %.c
	$(CC) -c $(CFLAGS) $(INCS) -o $@ $< -std=c99

clean:
	rm -rf obj/*o *.brig $(TEST_NAME)


test:	
	echo "export LD_LIBRARY_PATH=$(HSA_RUNTIME_PATH)/lib" > test.sh
	echo "./$(TEST_NAME)" >> test.sh
	bash test.sh
	rm test.sh


