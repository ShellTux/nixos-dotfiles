{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
	name = "sddm-lain-wired-theme";
	version = "0.9.1";

	src = fetchFromGitHub {
		owner = "lll2yu";
		repo = name;
		rev = version;
		sha256 = "0b0jqsxk9w2x7mmdnxipmd57lpj6sjj7il0cnhy0jza0vzssry4j";
	};

	installPhase = ''
		mkdir -p $out/share/sddm/themes
		cp -aR $src $out/share/sddm/themes/${name}
	'';
}

