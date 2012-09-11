# Visual Stupid Makefile - Auto Makefile; https://github.com/jhlicc
# Layout: [include/]  src/  (no additional directories)
# .c and Makefile in src; .h in include (can be in src)
# .cpp, CXX, CXXFLAGS for C++; CPPFLAGS for header include directory
 
OUT      = main.out
SRCS     = $(wildcard *.c)
OBJS     = $(patsubst %.c,%.o,$(SRCS))
CC       = gcc
CXX      = g++
CFLAGS   = -std=c99 -Wall -W
CXXFLAGS = -std=c++0x -Wall -W
CPPFLAGS = -I ../include
LDFLAGS  =
 
#CFLAGS  += -g
#CFLAGS  += -DNDEBUG
#CFLAGS  += -D_POSIX_SOURCE -D_BSD_SOURCE
#LDFLAGS += -lpthread
 
$(OUT): $(OBJS)
	$(CC) $(LDFLAGS) $^ -o $@
 
include $(SRCS:.c=.d)
 
%.d: %.c
	@set -e; rm -f $@; \
	$(CC) -M $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$
 
.PHONY: clean
clean:
	rm *.d *.d.* $(OBJS) $(OUT)
