{stdenv, lib, file}:
stdenv.mkDerivation rec {
  name = "custom_scripts";
  src = lib.cleanSource ./scripts;
  buildInputs = [ file ];
  installPhase = ''
    mkdir -p $out/bin/
    for i in $( \
      ls ${src} | \
      xargs file | \
      grep 'POSIX shell script' | \
      sed "s/^\(.*\):.*/\1/"
    )
    do
      install -Dm555 $i $out/bin/
      echo "installing $i..."
    done
    ''; 
}
