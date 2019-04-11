#!/usr/bin/env bash
python ../pyan.py `find . -name "*.py"`  --dot -c -g | fdp -Tpng
