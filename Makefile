diagrams: graphs/three-way-dh.dot 
	mkdir build
	dot -Tpdf graphs/three-way-dh.dot -o build/three-way-dh.pdf

clean: 
	rm -rf build
