MAIN=HAMOOPI

compile: clean
	cmake -DSHARED=OFF -S . -B build
	cmake --build build
	
clean:
	rm -rf ${MAIN} *.exe *.o build

docker:
	docker build . -t a4-mingw

shell:	docker
	docker run -it --rm -u `id -u`:`id -g` -v `pwd`:/workdir -w /workdir a4-mingw bash

zip:
	zip -r ${MAIN}-${PLATFORM}.zip backgrounds chars docs sounds system tools LICENSE README.md SETUP.ini ${MAIN} ${MAIN}.exe

linux:
	PLATFORM=linux CXX=g++ make compile	zip

windows:
	PLATFORM=windows CXX=i686-w64-mingw32-g++ make compile zip

mac:
	PLATFORM=mac CXX=clang make compile zip

zip-all: linux windows mac
