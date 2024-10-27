{
  stdenv,
  fetchFromGitHub,
  fetchFromGitLab,
}:
stdenv.mkDerivation rec {
  name = "sddm-lain-wired-theme";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "lll2yu";
    repo = name;
    rev = version;
    sha256 = "0b0jqsxk9w2x7mmdnxipmd57lpj6sjj7il0cnhy0jza0vzssry4j";
  };

  # src = fetchFromGitLab {
  # 	owner = "mixedCase";
  # 	repo = name;
  # 	rev = "4c98a329d62d40658657a2a4f54c44fe522c6117";
  # 	sha256 = "0vaxd2ic5qmkwqivjdspbvkrr8ihp6rzq3hi42dryn4bn2w0nzps";
  # };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/${name}
  '';
}
