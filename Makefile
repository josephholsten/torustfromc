CFLAGS=-Wall
LDLIBS=-ltorust -ldl
LDFLAGS=-pthread -L./target/debug/ 

PROGRAMS=torustfromc
SOURCES=torustfromc.c torust.h
#OBJECTS=torustfromc.o target/debug/libtorust.a
OBJECTS=target/debug/libtorust.a

all: ${SOURCES} ${OBJECTS} ${PROGRAMS}

torust.h: cbindgen.toml torust.rs
	cbindgen --config cbindgen.toml --crate torustfromc --output torust.h

target/debug/libtorust.a: torust.rs
	cargo build --lib

clean:
	rm -f ${PROGRAMS}
	rm -f ${OBJECTS}
	rm -rf target

clobber: clean
	rm -f torust.h
	rm -f Cargo.lock
