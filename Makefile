build:
	mkdir -p dist
	ca65 src/main.s -o dist/game.o -g
	ld65 -C memory.cfg dist/game.o -o dist/game.nes --dbgfile dist/game.dbg

clean:
	rm dist/*.o dist/*.nes

fceux:
	fceux dist/game.nes

run: build fceux
mesen: build
	/home/dcoulombe/Downloads/Mesen.exe dist/game.nes
