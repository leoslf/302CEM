all: docs

docs:
	$(MAKE) -C docs html

gengraph:
	cd manufacturing; ./gen_graph.sh > ../graph.png


.PHONY: docs
