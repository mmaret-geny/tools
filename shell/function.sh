
mgrep () {
    find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -regextype posix-egrep -iregex '(.*\/Makefile|.*\/Makefile\..*|.*\.make|.*\.mak|.*\.mk)' -type f -print0 | xargs -0 grep --color -n "$@"
}

cgrep () {
    find . -name .repo -prune -o -name .git -prune -o -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) -print0 | xargs -0 grep --color -n "$@"
}

jgrep () {
    find . -name .repo -prune -o -name .git -prune -o -type f -name "*\.java" -print0 | xargs -0 grep --color -n "$@"
}

cjgrep () {
    find . -name .repo -prune -o -name .git -prune -o -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' -o -name "*.java" \) -print0 | xargs -0 grep --color -n "$@"
}

resgrep () {
    for dir in `find . -name .repo -prune -o -name .git -prune -o -name res -type d`
        do
            find $dir -type f -name '*\.xml' -print0 | xargs -0 grep --color -n "$@"
                done
}

gettop ()
{
    local TOPFILE=build/core/envsetup.mk;
    if [ -n "$TOP" -a -f "$TOP/$TOPFILE" ]; then
        echo $TOP;
    else
        if [ -f $TOPFILE ]; then
            PWD= /bin/pwd;
        else
            local HERE=$PWD;
    T=;
    while [ \( ! \( -f $TOPFILE \) \) -a \( $PWD != "/" \) ]; do
        \cd ..;
    T=`PWD= /bin/pwd`;
    done;
    \cd $HERE;
    if [ -f "$T/$TOPFILE" ]; then
        echo $T;
    fi;
    fi;
    fi
}

croot ()
{
    T=$(gettop);
    if [ "$T" ]; then
        \cd $(gettop);
    else
        echo "Couldn't locate the top of the tree.  Try setting TOP.";
    fi
}

apush() {
    adb root && adb wait-for-device && adb remount && adb wait-for-device &&  adb push $1 $2
}
