.PHONY: build

all: build

build: clean
	# Create the Storiies directory
	mkdir -p build/Storiies

	# Copy bundle files
	cp -r bundle/* build/Storiies

	# Copy the application files
	cp -r src assets build/Storiies/
	cp -r main.lua conf.lua build/Storiies/

	# Create the zip file and rename to .muxapp
	cd build && zip -9 -r Storiies.zip .
	mv build/Storiies.zip build/Storiies.muxapp
	rm -rf build/Storiies

clean:
	rm -rf build
