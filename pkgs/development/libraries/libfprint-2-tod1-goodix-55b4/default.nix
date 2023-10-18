{ stdenv, lib, fetchFromGitHub, pkg-config, libfprint, libfprint-tod, gusb, udev
, nss, openssl, meson, pixman, ninja, glib, gobject-introspection, gtk-doc
, doctest, libgudev, opencv }:

stdenv.mkDerivation {
  pname = "libfprint-2-tod1-goodix-55b4";
  version = "1.94.4";

  src = fetchFromGitHub {
    owner = "TheWeirdDev";
    repo = "libfprint";
    rev = "92168daeed1c9cf4afb7ebbd27ab34e3d7b2419d";
    hash = "sha256-HaLNHEumpj0fgsiYFDs+vktWzbfdbHv5ejQcBpMHMfk=";
  };

  depsBuildBuild = [ pkg-config ];

  nativeBuildInputs =
    [ pkg-config meson ninja gtk-doc gobject-introspection doctest ];
  buildInputs = [
    libfprint
    libfprint-tod
    glib
    gusb
    udev
    nss
    openssl
    pixman
    libgudev
    opencv
  ];

  installPhase = ''
    runHook preInstall

    install -D -t "$out/lib/libfprint-2/tod-1/" libfprint-tod-goodix-55b4.so
    install -D -t "$out/lib/udev/rules.d/" $src/60-libfprint-2-tod1-goodix-55b4.rules

    runHook postInstall
  '';

  mesonFlags = [ "-D doc=false" ];

  mesonBuildType = "release";

  passthru.driverPath = "/lib/libfprint-2/tod-1";

  meta = with lib; {
    description =
      "A libfprint-2-tod Touch OEM Driver for the 2023 Lenovo Yoga 7i fingerprint readers";
    homepage =
      "https://github.com/TheWeirdDev/libfprint/tree/55b4-experimental";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ novaviper ];
  };
}
