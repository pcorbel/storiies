.PHONY: build

build: build-muos build-nextui build-knulli

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
	mkdir -p build/nextui

	# Copy bundle files
	cp -r bundles/nextui/* build/nextui
	cp -r bundles/shared/* build/nextui

	# Copy the README.md
	cp README.md build/nextui

	# Copy the application files
	cp -r src assets build/nextui
	cp -r main.lua conf.lua build/nextui

	# Create the zip file
	cd build/nextui && zip -9 -r Storiies.pak.zip .
	mv build/nextui/Storiies.pak.zip build/Storiies.pak.zip

	# Clean the build nextui directory
	rm -rf build/nextui

build-knulli:
	# Clean the build knulli directory
	rm -rf build/knulli

	# Create the Storiies directory
	mkdir -p build/knulli/Storiies

	# Copy bundle files
	cp -r bundles/knulli/*.gptk build/knulli/Storiies
	cp -r bundles/knulli/Storiies.sh build/knulli/Storiies.sh
	cp -r bundles/shared/* build/knulli/Storiies

	# Copy the README.md
	cp README.md build/knulli/Storiies/

	# Copy the application files
	cp -r src assets build/knulli/Storiies/
	cp -r main.lua conf.lua build/knulli/Storiies/

	# Create the zip file
	cd build/knulli && zip -9 -r Storiies.zip .
	mv build/knulli/Storiies.zip build/Storiies.zip

	# Clean the build knulli directory
	rm -rf build/knulli

clean:
	rm -rf build/*
	mkdir -p build
