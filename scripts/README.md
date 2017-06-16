This folder contains scripts to generate files to be used in other projects.

Be sure to have `pack-sdf` and `sdf2table` on your path.

## `mix-to-table.sh [project-path] [mix-filename]`

generates `.def` and `.tbl` file for mix syntax. files will be generated in current directory.

from this folder, you should call it like this:
```
./mix-to-table.sh ../javascript StrategoJS
```

## `pp-signatures-as-lib [project-path] [mix-filename]`

this script calls `mix-to-table` and adds the signatures and pretty printer in a lib folder. imports and module names are renamed to be able to include them in a language project in the `lib` folder.
