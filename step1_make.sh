#!/opt/homebrew/bin/bash
cd /Users/fong/Documents/github_repo/fongyq
mv docs/docs docs/build
cd docs
if [ "$1" = 'clean' ]
then
    make clean
fi
make html
rm -r doctrees
mv build/doctrees .
mv build/html docs
rm -r build
cp override_theme.css docs/_static/css/theme.css
cd ../
