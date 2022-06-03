{stdenv}:
stdenv.mkDerivation rec {
  pname = "template";
  version = "1.0";
  src = ./templates;
  installPhase = ''
    mkdir -p $out/bin

    echo Create the templating script...
    cat > template << EOF
      #!/bin/sh
      
      if [ "\$1" = "" ]
      then
        ls $out/templates
        exit
      fi
      install -Dm666 $out/templates/\$1 ./
    EOF
    install -Dm555 template $out/bin/template

    mkdir $out/templates
    for i in $(ls $src)
    do
      echo Copying $i
      install -Dm444 $i $out/templates/
    done
'';
}
