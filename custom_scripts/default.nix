{config; pkgs; lib; ...}:
{
  environment.extraPackages = [(
  lib.stdenv.mkDerivation {
    name = "custom_scripts"
    src = raw_script;
    installPhase = ''
      for i in $( \
        ls ${raw_script} | \
        xargs file | \
        grep 'POSIX shell script' | \
        sed "s/^\(.*\):.*/\1/"
      )
      do
        install -Dm644 $i $out/bin/
        echo "installing $i..."
      done
      ''; 
  }
  )];
}
