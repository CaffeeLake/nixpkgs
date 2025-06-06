{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  swig,
  msgpack,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "ihm";
  version = "2.5";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ihmwg";
    repo = "python-ihm";
    tag = version;
    hash = "sha256-U9Ytb2v9gzOu6MMz6HFn+yY5N+qCi692bN602Rt13S8=";
  };

  nativeBuildInputs = [ swig ];

  build-system = [ setuptools ];

  dependencies = [ msgpack ];

  nativeCheckInputs = [ pytestCheckHook ];

  disabledTests = [
    # requires network access
    "test_validator_example"
  ];

  pythonImportsCheck = [ "ihm" ];

  meta = with lib; {
    description = "Python package for handling IHM mmCIF and BinaryCIF files";
    homepage = "https://github.com/ihmwg/python-ihm";
    changelog = "https://github.com/ihmwg/python-ihm/blob/${src.tag}/ChangeLog.rst";
    license = licenses.mit;
    maintainers = with maintainers; [ natsukium ];
  };
}
