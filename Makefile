all: docs

docs:
	$(MAKE) -C docs html

.PHONY: docs
