.PHONY: build

build: build-muos build-nextui

build-muos:
	# Clean the build muos directory
	rm -rf build/muos

	# Create the Storiies directory
	mkdir -p build/muos/Storiies

	# Copy bundle files
	cp -r bundles/muos/* build/muos/Storiies
	cp -r bundles/shared/* build/muos/Storiies

	# Copy the README.md
	cp README.md build/muos/Storiies/

	# Copy the application files
	cp -r src assets build/muos/Storiies/
	cp -r main.lua conf.lua build/muos/Storiies/

	# Create the zip file and rename to .muxapp
	cd build/muos && zip -9 -r Storiies.zip .
	mv build/muos/Storiies.zip build/Storiies.muxapp

	# Clean the build muos directory
	rm -rf build/muos

build-nextui:
	# Clean the build nextui directory
	rm -rf build/nextui

	# Create the Storiies directory
	mkdir -p build/nextui/Storiies.pak

	# Copy bundle files
	cp -r bundles/nextui/* build/nextui/Storiies.pak
	cp -r bundles/shared/* build/nextui/Storiies.pak

	# Copy the README.md
	cp README.md build/nextui/Storiies.pak/

	# Copy the application files
	cp -r src assets build/nextui/Storiies.pak/
	cp -r main.lua conf.lua build/nextui/Storiies.pak/

	# Create the zip file
	cd build/nextui && zip -9 -r Storiies.pak.zip .
	mv build/nextui/Storiies.pak.zip build/Storiies.pak.zip

	# Clean the build nextui directory
	rm -rf build/nextui
