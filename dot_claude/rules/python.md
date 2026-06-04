# Python Rules

## Packaging

- `__init__.py` is a package marker — keep it empty unless explicitly re-exporting a public API; code belongs in named inner modules
- When converting `foo.py` to a package: `foo/__init__.py` (empty) + `foo/foo.py` (or a descriptive name)

## Testing

- Mirror `src/` structure in `tests/` — e.g. `src/calculator/calculator.py` → `tests/calculator/test_calculator.py`
- Test directories do not need `__init__.py`
- When packaging a module, move the corresponding test file to match
