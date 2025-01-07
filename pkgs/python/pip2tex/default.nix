{ pkgs, lib, ... }:
let
  inherit (pkgs.python3Packages) buildPythonPackage fetchPypi;
in
buildPythonPackage rec {
  pname = "pix2tex";
  version = "0.1.2";
  # "https://files.pythonhosted.org/packages/ef/51/e5a49cee59c8632723a18f7b1a5f2d431825f589b12f6d61891ba020d8fb/pix2tex-0.1.2-py3-none-any.whl";
  src = ./pix2tex-0.1.2-py3-none-any.whl;
  # src = fetchPypi {
  #   inherit pname version;
  #   sha256 = "dc6447c5a8a3a56fc8d0d4f75caa88f4656cb86b88d6a715a44f6000552ff097";
  # };

  nativeBuildInputs = with pkgs; [
    python312Packages.setuptools
    python312Packages.wheel
    findutils
  ];

  propagatedBuildInputs = with pkgs.python312Packages; [
    albucore
    albumentations
    einops
    munch
    numpy
    opencv4
    pandas
    pillow
    pynput
    pyqt6
    pyqt6-webengine
    pyside6
    pytorch
    requests
    screeninfo
    timm
    tokenizers
    tqdm
    transformers
    # x-transformers
    pyyaml
  ];

  passthru.optionalDependencies = {
    gnome-screenshot = pkgs.gnome-screenshot;
    grim = pkgs.grim;
    slurp = pkgs.slurp;
  };

  # The following part handles the additional weights and model files
  installPhase =
    let
      imageResizer = pkgs.fetchurl {
        url = "https://github.com/lukas-blecher/LaTeX-OCR/releases/download/v0.0.1/image_resizer.pth";
        sha256 = "1c3820659985ad142b526490bb25c23d977176ac2073591b3bddada692718458";
      };

      weights = pkgs.fetchurl {
        url = "https://github.com/lukas-blecher/LaTeX-OCR/releases/download/v0.0.1/weights.pth";
        sha256 = "a63d9141c53d266cb682fb5a8bd83bd5cbe283145e0e78ebdc0f895195a1dfaa";
      };
    in
    ''
      mkdir -p $out/lib/checkpoints
      cp ${imageResizer} $out/lib/checkpoints/
      cp ${weights} $out/lib/checkpoints/
    '';

  meta = with lib; {
    description = "Using a ViT to convert images of equations into LaTeX code";
    homepage = "https://github.com/lukas-blecher/LaTeX-OCR";
    license = licenses.mit;
    maintainers = with maintainers; [
    ];
    # Adjust the `done` and `conflicts` as needed to match your package's behavior
    conflicts = [ "python-pix2tex" ];
    replaces = [
      "python-pix2tex"
      "latexocr"
    ];
    arch = [ "x86_64" ];
  };
}
