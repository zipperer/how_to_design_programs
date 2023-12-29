## Docker
```bash
how_to_design_programs/python_setup $ docker build -t python3-pytest-mypy .
# in one terminal
how_to_design_programs/exercises $ docker run --name python3-pytest-mypy-container -it --rm -v "${PWD}":/exercises python3-pytest-mypy
...
# in second terminal
how_to_design_programs/exercises $ docker exec -it python3-pytest-mypy-container /bin/bash
# in container
/ $ cd exercises
/exercises $ python3 -m pytest FILENAME.py
/exercises $ python3 -m mypy FILENAME.py
/exercises $ python3 -m pytest ./*.py
```
