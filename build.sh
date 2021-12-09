QMAKE_DIR="qmake"

while [ -n "$1" ]
do
case "$1" in
-qmake) QMAKE_DIR="$2" ;;
esac
shift
done

BUILD_DIR=build

if [[ ! -d "$BUILD_DIR" ]]
then
    mkdir $BUILD_DIR
fi

cd $BUILD_DIR

$QMAKE_DIR ../NumbersModelPlugin
make

$QMAKE_DIR ../Puzzle15
make

./Puzzle15
    