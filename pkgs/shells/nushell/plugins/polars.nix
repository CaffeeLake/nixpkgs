{
  stdenv,
  lib,
  rustPlatform,
  openssl,
  nushell,
  pkg-config,
  nix-update-script,
}:

rustPlatform.buildRustPackage rec {
  pname = "nushell_plugin_polars";
  inherit (nushell) version src cargoHash;

  useFetchCargoVendor = true;

  nativeBuildInputs = [ pkg-config ] ++ lib.optionals stdenv.cc.isClang [ rustPlatform.bindgenHook ];
  buildInputs = [ openssl ];
  cargoBuildFlags = [ "--package nu_plugin_polars" ];

  checkPhase = ''
    # test failed without enough columns
    cargo test --manifest-path crates/nu_plugin_polars/Cargo.toml -- \
      --skip=dataframe::command::core::to_repr::test::test_examples
  '';

  passthru.updateScript = nix-update-script {
    # Skip the version check and only check the hash because we inherit version from nushell.
    extraArgs = [ "--version=skip" ];
  };

  meta = with lib; {
    description = "Nushell dataframe plugin commands based on polars";
    mainProgram = "nu_plugin_polars";
    homepage = "https://github.com/nushell/nushell/tree/${version}/crates/nu_plugin_polars";
    license = licenses.mit;
    maintainers = with maintainers; [ joaquintrinanes ];
    platforms = with platforms; all;
  };
}
