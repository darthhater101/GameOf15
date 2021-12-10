QMAKE_FILE="qmake"

while [ -n "$1" ]
do
case "$1" in
-qmake) QMAKE_FILE="$2" ;;
--help) echo "Usage: ./build.sh [option]"
        echo "By default \"qmake\" in PATH variable is used"
        echo "-qmake    path to qmake file"
        echo "--help    display help and exit"
        exit 0;;
esac
shift
done

BUILD_DIR=build

if [[ ! -d "$BUILD_DIR" ]]
then
    mkdir $BUILD_DIR
fi

cd $BUILD_DIR

$QMAKE_FILE ../NumbersModelPlugin
make

$QMAKE_FILE ../Puzzle15
make

./Puzzle15
