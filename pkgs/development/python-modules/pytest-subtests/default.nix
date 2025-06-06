{
  lib,
  buildPythonPackage,
  fetchPypi,
  pythonOlder,

  # build-system
  setuptools,
  setuptools-scm,

  # dependencies
  attrs,

  # tests
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "pytest-subtests";
  version = "0.14.1";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    pname = "pytest_subtests";
    inherit version;
    hash = "sha256-NQwArcNsOv9namYTXIGu2eIYLhX2w+yHITZpGLu/dYA=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
  ];

  propagatedBuildInputs = [ attrs ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "pytest_subtests" ];

  meta = with lib; {
    description = "Pytest plugin for unittest subTest() support and subtests fixture";
    homepage = "https://github.com/pytest-dev/pytest-subtests";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
