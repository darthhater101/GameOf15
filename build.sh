QMAKE_DIR="qmake"

while [ -n "$1" ]
do
case "$1" in
-qmake) QMAKE_DIR="$2" ;;
esac
shift
done

PLUGIN_BUILD_DIR=build-NumbersModelPlugin 
MAIN_BUILD_DIR=build-main

if [[ ! -d "$PLUGIN_BUILD_DIR" ]]
then
    mkdir $PLUGIN_BUILD_DIR
fi

cd $PLUGIN_BUILD_DIR

$QMAKE_DIR ../NumbersModelPlugin
make install

cd ..

if [[ ! -d "$MAIN_BUILD_DIR" ]]
then
    mkdir $MAIN_BUILD_DIR
fi

cd $MAIN_BUILD_DIR

$QMAKE_DIR ../Puzzle15
make

./Puzzle15