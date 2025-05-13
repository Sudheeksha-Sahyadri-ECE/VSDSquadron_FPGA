TOP_MODULE = led_counter
DEVICE = up5k
PACKAGE = sg48
PCF = vsdsquadron.pcf
SOURCES = led_counter.v

all: ${TOP_MODULE}.bin

${TOP_MODULE}.json: ${SOURCES}
	yosys -p "synth_ice40 -top ${TOP_MODULE} -json ${TOP_MODULE}.json" ${SOURCES}

${TOP_MODULE}.asc: ${TOP_MODULE}.json
	nextpnr-ice40 --${DEVICE} --package ${PACKAGE} --pcf ${PCF} --json ${TOP_MODULE}.json --asc ${TOP_MODULE}.asc

${TOP_MODULE}.bin: ${TOP_MODULE}.asc
	icepack ${TOP_MODULE}.asc ${TOP_MODULE}.bin

prog: ${TOP_MODULE}.bin
	iceprog ${TOP_MODULE}.bin

clean:
	rm -f *.json *.asc *.bin
